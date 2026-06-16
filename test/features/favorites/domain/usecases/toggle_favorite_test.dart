import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:crypto_tracker/features/favorites/domain/usecases/toggle_favorite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockFavorites extends Mock implements FavoritesRepository {}

void main() {
  late _MockFavorites repo;
  late ToggleFavorite usecase;

  setUp(() {
    repo = _MockFavorites();
    usecase = ToggleFavorite(repo);
  });

  test('delegates to repository.toggleFavorite and propagates Right(true)',
      () async {
    when(() => repo.toggleFavorite('bitcoin')).thenAnswer(
      (_) async => const Right<Failure, bool>(true),
    );

    final Either<Failure, bool> result = await usecase('bitcoin');

    expect(result, const Right<Failure, bool>(true));
    verify(() => repo.toggleFavorite('bitcoin')).called(1);
  });

  test('propagates Left(CacheFailure) from repository', () async {
    when(() => repo.toggleFavorite('bitcoin')).thenAnswer(
      (_) async => const Left<Failure, bool>(CacheFailure('disk full')),
    );

    final Either<Failure, bool> result = await usecase('bitcoin');

    expect(result, const Left<Failure, bool>(CacheFailure('disk full')));
  });
}
