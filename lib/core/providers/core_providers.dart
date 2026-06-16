import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../cache/hive_setup.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

final Provider<Dio> dioProvider = Provider<Dio>((Ref ref) {
  final Dio dio = DioClient.create();
  ref.onDispose(dio.close);
  return dio;
});

final Provider<Connectivity> connectivityProvider =
    Provider<Connectivity>((Ref ref) => Connectivity());

final Provider<NetworkInfo> networkInfoProvider = Provider<NetworkInfo>((
  Ref ref,
) {
  return NetworkInfoImpl(ref.watch(connectivityProvider));
});

final StreamProvider<bool> connectivityStreamProvider =
    StreamProvider<bool>((Ref ref) async* {
      final NetworkInfo info = ref.watch(networkInfoProvider);
      yield await info.isConnected;
      yield* info.onConnectivityChanged;
    });

final Provider<Box<String>> coinsCacheBoxProvider = Provider<Box<String>>(
  (Ref ref) => Hive.box<String>(HiveBoxNames.coinsCache),
);

final Provider<Box<String>> globalMarketCacheBoxProvider =
    Provider<Box<String>>(
      (Ref ref) => Hive.box<String>(HiveBoxNames.globalMarketCache),
    );

final Provider<Box<String>> trendingCacheBoxProvider = Provider<Box<String>>(
  (Ref ref) => Hive.box<String>(HiveBoxNames.trendingCache),
);

final Provider<Box<String>> coinDetailCacheBoxProvider = Provider<Box<String>>(
  (Ref ref) => Hive.box<String>(HiveBoxNames.coinDetailCache),
);

final Provider<Box<bool>> favoritesBoxProvider = Provider<Box<bool>>(
  (Ref ref) => Hive.box<bool>(HiveBoxNames.favorites),
);
