import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../data/datasources/market_local_datasource.dart';
import '../../data/datasources/market_remote_datasource.dart';
import '../../data/repositories/market_repository_impl.dart';
import '../../domain/repositories/market_repository.dart';
import '../../domain/usecases/get_coins.dart';
import '../../domain/usecases/get_global_market.dart';
import '../../domain/usecases/get_trending_coins.dart';

final Provider<MarketRemoteDataSource> marketRemoteDataSourceProvider =
    Provider<MarketRemoteDataSource>((Ref ref) {
      return MarketRemoteDataSourceImpl(ref.watch(dioProvider));
    });

final Provider<MarketLocalDataSource> marketLocalDataSourceProvider =
    Provider<MarketLocalDataSource>((Ref ref) {
      return MarketLocalDataSourceImpl(
        coinsBox: ref.watch(coinsCacheBoxProvider),
        globalBox: ref.watch(globalMarketCacheBoxProvider),
        trendingBox: ref.watch(trendingCacheBoxProvider),
      );
    });

final Provider<MarketRepository> marketRepositoryProvider =
    Provider<MarketRepository>((Ref ref) {
      return MarketRepositoryImpl(
        remote: ref.watch(marketRemoteDataSourceProvider),
        local: ref.watch(marketLocalDataSourceProvider),
        favorites: ref.watch(favoritesRepositoryProvider),
        networkInfo: ref.watch(networkInfoProvider),
      );
    });

final Provider<GetCoins> getCoinsProvider = Provider<GetCoins>((Ref ref) {
  return GetCoins(ref.watch(marketRepositoryProvider));
});

final Provider<GetGlobalMarket> getGlobalMarketProvider =
    Provider<GetGlobalMarket>(
      (Ref ref) => GetGlobalMarket(ref.watch(marketRepositoryProvider)),
    );

final Provider<GetTrendingCoins> getTrendingCoinsProvider =
    Provider<GetTrendingCoins>(
      (Ref ref) => GetTrendingCoins(ref.watch(marketRepositoryProvider)),
    );
