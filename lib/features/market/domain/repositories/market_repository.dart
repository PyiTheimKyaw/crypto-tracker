import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/coin.dart';
import '../entities/global_market.dart';
import '../entities/trending_coin.dart';

abstract interface class MarketRepository {
  Future<Either<Failure, List<Coin>>> getCoins({required int page});

  Future<Either<Failure, GlobalMarket>> getGlobalMarket();

  Future<Either<Failure, List<TrendingCoin>>> getTrendingCoins();
}
