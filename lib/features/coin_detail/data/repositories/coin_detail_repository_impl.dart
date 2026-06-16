import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import '../../domain/entities/coin_detail.dart';
import '../../domain/repositories/coin_detail_repository.dart';
import '../datasources/coin_detail_local_datasource.dart';
import '../datasources/coin_detail_remote_datasource.dart';
import '../models/coin_detail_model.dart';

class CoinDetailRepositoryImpl implements CoinDetailRepository {
  const CoinDetailRepositoryImpl({
    required this.remote,
    required this.local,
    required this.favorites,
    required this.networkInfo,
  });

  final CoinDetailRemoteDataSource remote;
  final CoinDetailLocalDataSource local;
  final FavoritesRepository favorites;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, CoinDetail>> getCoinDetail(String id) async {
    final bool online = await networkInfo.isConnected;

    if (online) {
      try {
        final CoinDetailModel model = await remote.getCoinDetail(id);
        await local.cache(id, model);
        final Set<String> favIds = await favorites.getFavoriteIds();
        return Right<Failure, CoinDetail>(
          model.toEntity(isFavorite: favIds.contains(id)),
        );
      } on ServerException catch (e) {
        return Left<Failure, CoinDetail>(ServerFailure(e.message));
      }
    }

    try {
      final CoinDetailModel cached = await local.getCached(id);
      final Set<String> favIds = await favorites.getFavoriteIds();
      return Right<Failure, CoinDetail>(
        cached.toEntity(isFavorite: favIds.contains(id)),
      );
    } on CacheException {
      return const Left<Failure, CoinDetail>(NetworkFailure());
    }
  }
}
