import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/coin_detail/domain/entities/coin_detail.dart';
import 'package:crypto_tracker/features/coin_detail/domain/repositories/coin_detail_repository.dart';
import 'package:crypto_tracker/features/coin_detail/domain/usecases/get_coin_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements CoinDetailRepository {}

const CoinDetail _tDetail = CoinDetail(
  id: 'ethereum',
  symbol: 'eth',
  name: 'Ethereum',
  image: 'https://example.com/eth.png',
  marketCapRank: 2,
  currentPrice: 2095.85,
  priceChangePercentage24h: -0.13,
  marketCap: 253150000000,
  totalVolume: 9780000000,
  ath: 4878.00,
  athChangePercentage: -57.03,
  atl: 0.43,
  atlChangePercentage: 487306.98,
  circulatingSupply: 120280000,
  totalSupply: 120280000,
  maxSupply: null,
  description: 'Ethereum is...',
);

void main() {
  late _MockRepo repo;
  late GetCoinDetail usecase;

  setUp(() {
    repo = _MockRepo();
    usecase = GetCoinDetail(repo);
  });

  test('returns Right(CoinDetail) when repository succeeds', () async {
    when(() => repo.getCoinDetail('ethereum')).thenAnswer(
      (_) async => const Right<Failure, CoinDetail>(_tDetail),
    );

    final Either<Failure, CoinDetail> result = await usecase('ethereum');

    expect(result, const Right<Failure, CoinDetail>(_tDetail));
    verify(() => repo.getCoinDetail('ethereum')).called(1);
  });

  test('propagates ServerFailure from the repository', () async {
    when(() => repo.getCoinDetail('btc')).thenAnswer(
      (_) async =>
          const Left<Failure, CoinDetail>(ServerFailure('HTTP 500')),
    );

    final Either<Failure, CoinDetail> result = await usecase('btc');

    expect(
      result,
      const Left<Failure, CoinDetail>(ServerFailure('HTTP 500')),
    );
  });
}
