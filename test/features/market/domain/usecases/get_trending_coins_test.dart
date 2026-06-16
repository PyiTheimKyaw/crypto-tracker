import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/domain/usecases/get_trending_coins.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/market_mocks.dart';

void main() {
  late MockMarketRepository repository;
  late GetTrendingCoins usecase;

  setUp(() {
    repository = MockMarketRepository();
    usecase = GetTrendingCoins(repository);
  });

  group('GetTrendingCoins', () {
    test('returns Right(List<TrendingCoin>) when repository succeeds', () async {
      when(repository.getTrendingCoins)
          .thenAnswer(
            (_) async =>
                const Right<Failure, List<TrendingCoin>>(tTrendingList),
          );

      final Either<Failure, List<TrendingCoin>> result = await usecase();

      expect(
        result,
        const Right<Failure, List<TrendingCoin>>(tTrendingList),
      );
      verify(repository.getTrendingCoins).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('propagates ServerFailure from repository', () async {
      const ServerFailure failure = ServerFailure('upstream 500');
      when(repository.getTrendingCoins)
          .thenAnswer(
            (_) async => const Left<Failure, List<TrendingCoin>>(failure),
          );

      final Either<Failure, List<TrendingCoin>> result = await usecase();

      expect(result, const Left<Failure, List<TrendingCoin>>(failure));
    });

    test('propagates NetworkFailure from repository', () async {
      const NetworkFailure failure = NetworkFailure();
      when(repository.getTrendingCoins)
          .thenAnswer(
            (_) async => const Left<Failure, List<TrendingCoin>>(failure),
          );

      final Either<Failure, List<TrendingCoin>> result = await usecase();

      expect(result, const Left<Failure, List<TrendingCoin>>(failure));
    });
  });
}
