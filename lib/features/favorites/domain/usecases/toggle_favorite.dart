import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavorite {
  const ToggleFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Either<Failure, bool>> call(String id) =>
      _repository.toggleFavorite(id);
}
