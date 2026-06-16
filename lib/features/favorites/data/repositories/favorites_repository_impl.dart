import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._local);

  final FavoritesLocalDataSource _local;

  @override
  Future<Set<String>> getFavoriteIds() async => _local.getFavoriteIds();

  @override
  Stream<Set<String>> watchFavorites() async* {
    yield _local.getFavoriteIds();
    yield* _local.watch();
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(String id) async {
    try {
      if (_local.isFavorite(id)) {
        await _local.remove(id);
        return const Right<Failure, bool>(false);
      }
      await _local.add(id);
      return const Right<Failure, bool>(true);
    } catch (e) {
      return Left<Failure, bool>(CacheFailure(e.toString()));
    }
  }
}
