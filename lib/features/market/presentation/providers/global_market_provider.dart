import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/global_market.dart';
import '../../domain/usecases/get_global_market.dart';
import 'market_providers.dart';

final FutureProvider<GlobalMarket> globalMarketProvider =
    FutureProvider<GlobalMarket>((Ref ref) async {
      final GetGlobalMarket usecase = ref.watch(getGlobalMarketProvider);
      final Either<Failure, GlobalMarket> result = await usecase();
      return result.fold(
        (Failure failure) => throw failure,
        (GlobalMarket data) => data,
      );
    });
