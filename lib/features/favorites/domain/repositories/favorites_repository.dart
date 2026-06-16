import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class FavoritesRepository {
  Future<Set<String>> getFavoriteIds();

  Stream<Set<String>> watchFavorites();

  Future<Either<Failure, bool>> toggleFavorite(String id);
}
