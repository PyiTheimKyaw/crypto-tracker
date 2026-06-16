import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveBoxNames {
  const HiveBoxNames._();

  static const String coinsCache = 'coins_cache';
  static const String globalMarketCache = 'global_market_cache';
  static const String trendingCache = 'trending_cache';
  static const String favorites = 'favorites';
}

Future<void> initHive() async {
  await Hive.initFlutter();

  await Future.wait<void>(<Future<void>>[
    Hive.openBox<String>(HiveBoxNames.coinsCache).then((_) {}),
    Hive.openBox<String>(HiveBoxNames.globalMarketCache).then((_) {}),
    Hive.openBox<String>(HiveBoxNames.trendingCache).then((_) {}),
    Hive.openBox<bool>(HiveBoxNames.favorites).then((_) {}),
  ]);
}
