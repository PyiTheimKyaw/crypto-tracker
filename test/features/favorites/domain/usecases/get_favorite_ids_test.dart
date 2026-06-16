import 'package:crypto_tracker/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:crypto_tracker/features/favorites/domain/usecases/get_favorite_ids.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFavorites extends Mock implements FavoritesRepository {}

void main() {
  late _MockFavorites repo;
  late GetFavoriteIds usecase;

  setUp(() {
    repo = _MockFavorites();
    usecase = GetFavoriteIds(repo);
  });

  test('delegates to repository.getFavoriteIds', () async {
    when(repo.getFavoriteIds)
        .thenAnswer((_) async => <String>{'bitcoin', 'ethereum'});

    final Set<String> result = await usecase();

    expect(result, <String>{'bitcoin', 'ethereum'});
    verify(repo.getFavoriteIds).called(1);
  });
}
