import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/favorites_repository.dart';

class _StubFavoritesRepository implements FavoritesRepository {
  const _StubFavoritesRepository();

  @override
  Future<Set<String>> getFavoriteIds() async => const <String>{};
}

final Provider<FavoritesRepository> favoritesRepositoryProvider =
    Provider<FavoritesRepository>(
      (Ref ref) => const _StubFavoritesRepository(),
    );
