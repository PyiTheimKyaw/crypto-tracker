abstract interface class FavoritesRepository {
  Future<Set<String>> getFavoriteIds();
}
