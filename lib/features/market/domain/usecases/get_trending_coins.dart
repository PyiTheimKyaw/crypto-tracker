import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/trending_coin.dart';
import '../repositories/market_repository.dart';

class GetTrendingCoins {
  const GetTrendingCoins(this._repository);

  final MarketRepository _repository;

  Future<Either<Failure, List<TrendingCoin>>> call() =>
      _repository.getTrendingCoins();
}
