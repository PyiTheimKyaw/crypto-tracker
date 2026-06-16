import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/global_market.dart';
import '../repositories/market_repository.dart';

class GetGlobalMarket {
  const GetGlobalMarket(this._repository);

  final MarketRepository _repository;

  Future<Either<Failure, GlobalMarket>> call() =>
      _repository.getGlobalMarket();
}
