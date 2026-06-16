import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../data/datasources/coin_detail_remote_datasource.dart';
import '../../data/repositories/coin_detail_repository_impl.dart';
import '../../domain/entities/coin_detail.dart';
import '../../domain/repositories/coin_detail_repository.dart';
import '../../domain/usecases/get_coin_detail.dart';

final Provider<CoinDetailRemoteDataSource> coinDetailRemoteDataSourceProvider =
    Provider<CoinDetailRemoteDataSource>((Ref ref) {
      return CoinDetailRemoteDataSourceImpl(ref.watch(dioProvider));
    });

final Provider<CoinDetailRepository> coinDetailRepositoryProvider =
    Provider<CoinDetailRepository>((Ref ref) {
      return CoinDetailRepositoryImpl(
        remote: ref.watch(coinDetailRemoteDataSourceProvider),
        favorites: ref.watch(favoritesRepositoryProvider),
        networkInfo: ref.watch(networkInfoProvider),
      );
    });

final Provider<GetCoinDetail> getCoinDetailProvider = Provider<GetCoinDetail>(
  (Ref ref) => GetCoinDetail(ref.watch(coinDetailRepositoryProvider)),
);

final coinDetailProvider =
    FutureProvider.family<CoinDetail, String>((Ref ref, String id) async {
      final GetCoinDetail usecase = ref.watch(getCoinDetailProvider);
      final Either<Failure, CoinDetail> result = await usecase(id);
      return result.fold(
        (Failure failure) => throw failure,
        (CoinDetail data) => data,
      );
    });
