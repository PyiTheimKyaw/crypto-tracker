import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/coin_detail.dart';

abstract interface class CoinDetailRepository {
  Future<Either<Failure, CoinDetail>> getCoinDetail(String id);
}
