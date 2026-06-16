import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/usecases/get_global_market.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/market_mocks.dart';

void main() {
  late MockMarketRepository repository;
  late GetGlobalMarket usecase;

  setUp(() {
    repository = MockMarketRepository();
    usecase = GetGlobalMarket(repository);
  });

  group('GetGlobalMarket', () {
    test('returns Right(GlobalMarket) when repository succeeds', () async {
      when(repository.getGlobalMarket)
          .thenAnswer(
            (_) async => const Right<Failure, GlobalMarket>(tGlobalMarket),
          );

      final Either<Failure, GlobalMarket> result = await usecase();

      expect(result, const Right<Failure, GlobalMarket>(tGlobalMarket));
      verify(repository.getGlobalMarket).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('propagates ServerFailure from repository', () async {
      const ServerFailure failure = ServerFailure();
      when(repository.getGlobalMarket)
          .thenAnswer((_) async => const Left<Failure, GlobalMarket>(failure));

      final Either<Failure, GlobalMarket> result = await usecase();

      expect(result, const Left<Failure, GlobalMarket>(failure));
    });

    test('propagates CacheFailure from repository', () async {
      const CacheFailure failure = CacheFailure();
      when(repository.getGlobalMarket)
          .thenAnswer((_) async => const Left<Failure, GlobalMarket>(failure));

      final Either<Failure, GlobalMarket> result = await usecase();

      expect(result, const Left<Failure, GlobalMarket>(failure));
    });
  });
}
