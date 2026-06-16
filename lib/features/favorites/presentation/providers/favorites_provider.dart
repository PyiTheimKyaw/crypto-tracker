import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/favorites_local_datasource.dart';
import '../../data/repositories/favorites_repository_impl.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../domain/usecases/get_favorite_ids.dart';
import '../../domain/usecases/toggle_favorite.dart';

final Provider<FavoritesLocalDataSource> favoritesLocalDataSourceProvider =
    Provider<FavoritesLocalDataSource>((Ref ref) {
      return FavoritesLocalDataSourceImpl(ref.watch(favoritesBoxProvider));
    });

final Provider<FavoritesRepository> favoritesRepositoryProvider =
    Provider<FavoritesRepository>((Ref ref) {
      return FavoritesRepositoryImpl(
        ref.watch(favoritesLocalDataSourceProvider),
      );
    });

final StreamProvider<Set<String>> favoritesStreamProvider =
    StreamProvider<Set<String>>((Ref ref) {
      return ref.watch(favoritesRepositoryProvider).watchFavorites();
    });

final Provider<GetFavoriteIds> getFavoriteIdsProvider = Provider<GetFavoriteIds>(
  (Ref ref) => GetFavoriteIds(ref.watch(favoritesRepositoryProvider)),
);

final Provider<ToggleFavorite> toggleFavoriteProvider = Provider<ToggleFavorite>(
  (Ref ref) => ToggleFavorite(ref.watch(favoritesRepositoryProvider)),
);
