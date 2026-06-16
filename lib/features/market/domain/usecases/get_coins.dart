import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/coin.dart';
import '../repositories/market_repository.dart';

class GetCoins {
  const GetCoins(this._repository);

  final MarketRepository _repository;

  Future<Either<Failure, List<Coin>>> call({required int page}) =>
      _repository.getCoins(page: page);
}
