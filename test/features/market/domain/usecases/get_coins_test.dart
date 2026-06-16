import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:crypto_tracker/features/market/domain/usecases/get_coins.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/market_mocks.dart';

void main() {
  late MockMarketRepository repository;
  late GetCoins usecase;

  setUp(() {
    repository = MockMarketRepository();
    usecase = GetCoins(repository);
  });

  group('GetCoins', () {
    test('returns Right(List<Coin>) when repository succeeds', () async {
      when(() => repository.getCoins(page: 1))
          .thenAnswer((_) async => const Right<Failure, List<Coin>>(tCoinsPage1));

      final Either<Failure, List<Coin>> result = await usecase(page: 1);

      expect(result, const Right<Failure, List<Coin>>(tCoinsPage1));
      verify(() => repository.getCoins(page: 1)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('forwards the requested page to the repository', () async {
      when(() => repository.getCoins(page: 3))
          .thenAnswer((_) async => const Right<Failure, List<Coin>>(<Coin>[]));

      await usecase(page: 3);

      verify(() => repository.getCoins(page: 3)).called(1);
    });

    test('propagates ServerFailure from repository', () async {
      const ServerFailure failure = ServerFailure('boom');
      when(() => repository.getCoins(page: 1))
          .thenAnswer((_) async => const Left<Failure, List<Coin>>(failure));

      final Either<Failure, List<Coin>> result = await usecase(page: 1);

      expect(result, const Left<Failure, List<Coin>>(failure));
    });

    test('propagates NetworkFailure from repository', () async {
      const NetworkFailure failure = NetworkFailure();
      when(() => repository.getCoins(page: 2))
          .thenAnswer((_) async => const Left<Failure, List<Coin>>(failure));

      final Either<Failure, List<Coin>> result = await usecase(page: 2);

      expect(result, const Left<Failure, List<Coin>>(failure));
    });
  });
}
