import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/coin_detail.dart';
import '../repositories/coin_detail_repository.dart';

class GetCoinDetail {
  const GetCoinDetail(this._repository);

  final CoinDetailRepository _repository;

  Future<Either<Failure, CoinDetail>> call(String id) =>
      _repository.getCoinDetail(id);
}
