import 'dart:async';

import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:crypto_tracker/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocal extends Mock implements FavoritesLocalDataSource {}

void main() {
  late _MockLocal local;
  late FavoritesRepositoryImpl repo;

  setUp(() {
    local = _MockLocal();
    repo = FavoritesRepositoryImpl(local);
  });

  group('toggleFavorite', () {
    test('adds id and returns Right(true) when not yet favorited', () async {
      when(() => local.isFavorite('bitcoin')).thenReturn(false);
      when(() => local.add('bitcoin')).thenAnswer((_) async {});

      final Either<Failure, bool> result = await repo.toggleFavorite('bitcoin');

      expect(result, const Right<Failure, bool>(true));
      verify(() => local.add('bitcoin')).called(1);
      verifyNever(() => local.remove(any()));
    });

    test('removes id and returns Right(false) when already favorited',
        () async {
      when(() => local.isFavorite('bitcoin')).thenReturn(true);
      when(() => local.remove('bitcoin')).thenAnswer((_) async {});

      final Either<Failure, bool> result = await repo.toggleFavorite('bitcoin');

      expect(result, const Right<Failure, bool>(false));
      verify(() => local.remove('bitcoin')).called(1);
      verifyNever(() => local.add(any()));
    });

    test('wraps thrown errors as Left(CacheFailure)', () async {
      when(() => local.isFavorite('bitcoin')).thenReturn(false);
      when(() => local.add('bitcoin'))
          .thenThrow(StateError('hive crashed'));

      final Either<Failure, bool> result = await repo.toggleFavorite('bitcoin');

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<CacheFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('getFavoriteIds', () {
    test('returns the local data source set', () async {
      when(local.getFavoriteIds)
          .thenReturn(<String>{'bitcoin', 'ethereum'});

      final Set<String> result = await repo.getFavoriteIds();

      expect(result, <String>{'bitcoin', 'ethereum'});
    });
  });

  group('watchFavorites', () {
    test('emits the initial state immediately, then deltas from watch()',
        () async {
      final StreamController<Set<String>> controller =
          StreamController<Set<String>>();
      addTearDown(() async => controller.close());

      when(local.getFavoriteIds).thenReturn(<String>{'bitcoin'});
      when(local.watch).thenAnswer((_) => controller.stream);

      final List<Set<String>> emissions = <Set<String>>[];
      final StreamSubscription<Set<String>> sub =
          repo.watchFavorites().listen(emissions.add);
      addTearDown(sub.cancel);

      await Future<void>.delayed(Duration.zero);
      expect(emissions, <Set<String>>[<String>{'bitcoin'}]);

      controller.add(<String>{'bitcoin', 'ethereum'});
      await Future<void>.delayed(Duration.zero);
      expect(emissions, <Set<String>>[
        <String>{'bitcoin'},
        <String>{'bitcoin', 'ethereum'},
      ]);
    });
  });
}
