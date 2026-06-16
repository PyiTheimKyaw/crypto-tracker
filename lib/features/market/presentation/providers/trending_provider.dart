import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/trending_coin.dart';
import '../../domain/usecases/get_trending_coins.dart';
import 'market_providers.dart';

final FutureProvider<List<TrendingCoin>> trendingProvider =
    FutureProvider<List<TrendingCoin>>((Ref ref) async {
      final GetTrendingCoins usecase = ref.watch(getTrendingCoinsProvider);
      final Either<Failure, List<TrendingCoin>> result = await usecase();
      return result.fold(
        (Failure failure) => throw failure,
        (List<TrendingCoin> data) => data,
      );
    });
