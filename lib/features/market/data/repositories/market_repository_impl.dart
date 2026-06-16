import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import '../../domain/entities/coin.dart';
import '../../domain/entities/global_market.dart';
import '../../domain/entities/trending_coin.dart';
import '../../domain/repositories/market_repository.dart';
import '../datasources/market_local_datasource.dart';
import '../datasources/market_remote_datasource.dart';
import '../models/coin_model.dart';
import '../models/global_market_model.dart';
import '../models/trending_coin_model.dart';

class MarketRepositoryImpl implements MarketRepository {
  const MarketRepositoryImpl({
    required this.remote,
    required this.local,
    required this.favorites,
    required this.networkInfo,
  });

  final MarketRemoteDataSource remote;
  final MarketLocalDataSource local;
  final FavoritesRepository favorites;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Coin>>> getCoins({required int page}) async {
    final bool online = await networkInfo.isConnected;

    if (online) {
      try {
        final List<CoinModel> models = await remote.getCoins(page: page);
        if (page == 1) {
          await local.cacheCoinsPage1(models);
        }
        final Set<String> favIds = await favorites.getFavoriteIds();
        return Right<Failure, List<Coin>>(_mergeFavorites(models, favIds));
      } on ServerException catch (e) {
        return Left<Failure, List<Coin>>(ServerFailure(e.message));
      }
    }

    if (page > 1) {
      return const Left<Failure, List<Coin>>(NetworkFailure());
    }

    try {
      final List<CoinModel> models = await local.getCachedCoinsPage1();
      final Set<String> favIds = await favorites.getFavoriteIds();
      return Right<Failure, List<Coin>>(_mergeFavorites(models, favIds));
    } on CacheException {
      return const Left<Failure, List<Coin>>(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, GlobalMarket>> getGlobalMarket() async {
    final bool online = await networkInfo.isConnected;

    if (online) {
      try {
        final model = await remote.getGlobalMarket();
        await local.cacheGlobalMarket(model);
        return Right<Failure, GlobalMarket>(model.toEntity());
      } on ServerException catch (e) {
        return Left<Failure, GlobalMarket>(ServerFailure(e.message));
      }
    }

    try {
      final model = await local.getCachedGlobalMarket();
      return Right<Failure, GlobalMarket>(model.toEntity());
    } on CacheException {
      return const Left<Failure, GlobalMarket>(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<TrendingCoin>>> getTrendingCoins() async {
    final bool online = await networkInfo.isConnected;

    if (online) {
      try {
        final models = await remote.getTrendingCoins();
        await local.cacheTrendingCoins(models);
        return Right<Failure, List<TrendingCoin>>(
          models.map((m) => m.toEntity()).toList(),
        );
      } on ServerException catch (e) {
        return Left<Failure, List<TrendingCoin>>(ServerFailure(e.message));
      }
    }

    try {
      final models = await local.getCachedTrendingCoins();
      return Right<Failure, List<TrendingCoin>>(
        models.map((m) => m.toEntity()).toList(),
      );
    } on CacheException {
      return const Left<Failure, List<TrendingCoin>>(NetworkFailure());
    }
  }

  List<Coin> _mergeFavorites(List<CoinModel> models, Set<String> favIds) {
    return models
        .map((CoinModel m) => m.toEntity(isFavorite: favIds.contains(m.id)))
        .toList();
  }
}
