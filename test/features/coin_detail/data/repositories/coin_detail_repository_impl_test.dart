import 'package:crypto_tracker/core/error/exceptions.dart';
import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/core/network/network_info.dart';
import 'package:crypto_tracker/features/coin_detail/data/datasources/coin_detail_local_datasource.dart';
import 'package:crypto_tracker/features/coin_detail/data/datasources/coin_detail_remote_datasource.dart';
import 'package:crypto_tracker/features/coin_detail/data/models/coin_detail_model.dart';
import 'package:crypto_tracker/features/coin_detail/data/repositories/coin_detail_repository_impl.dart';
import 'package:crypto_tracker/features/coin_detail/domain/entities/coin_detail.dart';
import 'package:crypto_tracker/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements CoinDetailRemoteDataSource {}

class _MockLocal extends Mock implements CoinDetailLocalDataSource {}

class _MockFavorites extends Mock implements FavoritesRepository {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

const CoinDetailModel _tModel = CoinDetailModel(
  id: 'ethereum',
  symbol: 'eth',
  name: 'Ethereum',
  marketCapRank: 2,
  image: CoinDetailImageModel(large: 'https://example.com/eth.png'),
  description: CoinDetailDescriptionModel(en: 'Ethereum is...'),
  marketData: CoinDetailMarketDataModel(
    currentPrice: <String, double>{'usd': 2095.85},
    marketCap: <String, double>{'usd': 253150000000},
    totalVolume: <String, double>{'usd': 9780000000},
    ath: <String, double>{'usd': 4878.00},
    athChangePercentage: <String, double>{'usd': -57.03},
    atl: <String, double>{'usd': 0.43},
    atlChangePercentage: <String, double>{'usd': 487306.98},
    priceChangePercentage24h: -0.13,
    circulatingSupply: 120280000,
    totalSupply: 120280000,
  ),
);

void main() {
  late _MockRemote remote;
  late _MockLocal local;
  late _MockFavorites favorites;
  late _MockNetworkInfo network;
  late CoinDetailRepositoryImpl repo;

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    favorites = _MockFavorites();
    network = _MockNetworkInfo();
    repo = CoinDetailRepositoryImpl(
      remote: remote,
      local: local,
      favorites: favorites,
      networkInfo: network,
    );
    registerFallbackValue(_tModel);
  });

  group('online', () {
    setUp(() {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => local.cache(any(), any())).thenAnswer((_) async {});
    });

    test('returns Right(entity), caches it, and marks favorite when id in set',
        () async {
      when(() => remote.getCoinDetail('ethereum'))
          .thenAnswer((_) async => _tModel);
      when(favorites.getFavoriteIds)
          .thenAnswer((_) async => <String>{'ethereum', 'bitcoin'});

      final Either<Failure, CoinDetail> result =
          await repo.getCoinDetail('ethereum');

      expect(result.isRight(), isTrue);
      final CoinDetail entity =
          result.getRight().getOrElse(() => throw StateError('no value'));
      expect(entity.id, 'ethereum');
      expect(entity.isFavorite, isTrue);
      expect(entity.currentPrice, 2095.85);
      verify(() => local.cache('ethereum', _tModel)).called(1);
    });

    test('returns Right(entity) with isFavorite=false when id not in set',
        () async {
      when(() => remote.getCoinDetail('ethereum'))
          .thenAnswer((_) async => _tModel);
      when(favorites.getFavoriteIds)
          .thenAnswer((_) async => <String>{'bitcoin'});

      final Either<Failure, CoinDetail> result =
          await repo.getCoinDetail('ethereum');

      final CoinDetail entity =
          result.getRight().getOrElse(() => throw StateError('no value'));
      expect(entity.isFavorite, isFalse);
    });

    test('returns Left(ServerFailure) on remote ServerException', () async {
      when(() => remote.getCoinDetail('ethereum'))
          .thenThrow(const ServerException('HTTP 429 · rate limit'));

      final Either<Failure, CoinDetail> result =
          await repo.getCoinDetail('ethereum');

      expect(
        result,
        const Left<Failure, CoinDetail>(
          ServerFailure('HTTP 429 · rate limit'),
        ),
      );
      verifyNever(() => local.cache(any(), any()));
    });
  });

  group('offline', () {
    setUp(() {
      when(() => network.isConnected).thenAnswer((_) async => false);
    });

    test('cache hit → Right(cached entity) with favorite merged', () async {
      when(() => local.getCached('ethereum'))
          .thenAnswer((_) async => _tModel);
      when(favorites.getFavoriteIds)
          .thenAnswer((_) async => <String>{'ethereum'});

      final Either<Failure, CoinDetail> result =
          await repo.getCoinDetail('ethereum');

      expect(result.isRight(), isTrue);
      final CoinDetail entity =
          result.getRight().getOrElse(() => throw StateError('no value'));
      expect(entity.id, 'ethereum');
      expect(entity.isFavorite, isTrue);
      verifyNever(() => remote.getCoinDetail(any()));
    });

    test('cache miss → Left(NetworkFailure)', () async {
      when(() => local.getCached('ethereum'))
          .thenThrow(const CacheException());

      final Either<Failure, CoinDetail> result =
          await repo.getCoinDetail('ethereum');

      expect(
        result,
        const Left<Failure, CoinDetail>(NetworkFailure()),
      );
      verifyNever(() => remote.getCoinDetail(any()));
    });
  });
}
