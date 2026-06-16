import 'dart:convert';

import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/coin_model.dart';
import '../models/global_market_model.dart';
import '../models/trending_coin_model.dart';

abstract interface class MarketLocalDataSource {
  Future<List<CoinModel>> getCachedCoinsPage1();
  Future<void> cacheCoinsPage1(List<CoinModel> coins);

  Future<GlobalMarketModel> getCachedGlobalMarket();
  Future<void> cacheGlobalMarket(GlobalMarketModel market);

  Future<List<TrendingCoinModel>> getCachedTrendingCoins();
  Future<void> cacheTrendingCoins(List<TrendingCoinModel> coins);
}

class MarketLocalDataSourceImpl implements MarketLocalDataSource {
  const MarketLocalDataSourceImpl({
    required this.coinsBox,
    required this.globalBox,
    required this.trendingBox,
  });

  final Box<String> coinsBox;
  final Box<String> globalBox;
  final Box<String> trendingBox;

  static const String _coinsKey = 'page_1';
  static const String _globalKey = 'data';
  static const String _trendingKey = 'data';

  @override
  Future<void> cacheCoinsPage1(List<CoinModel> coins) async {
    final String encoded = jsonEncode(
      coins.map((CoinModel c) => c.toJson()).toList(),
    );
    await coinsBox.put(_coinsKey, encoded);
  }

  @override
  Future<List<CoinModel>> getCachedCoinsPage1() async {
    final String? raw = coinsBox.get(_coinsKey);
    if (raw == null) {
      throw const CacheException('No cached coins for page 1');
    }
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map<CoinModel>(
          (dynamic e) => CoinModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> cacheGlobalMarket(GlobalMarketModel market) async {
    await globalBox.put(_globalKey, jsonEncode(market.toJson()));
  }

  @override
  Future<GlobalMarketModel> getCachedGlobalMarket() async {
    final String? raw = globalBox.get(_globalKey);
    if (raw == null) {
      throw const CacheException('No cached global market');
    }
    final Map<String, dynamic> decoded =
        jsonDecode(raw) as Map<String, dynamic>;
    return GlobalMarketModel.fromJson(decoded);
  }

  @override
  Future<void> cacheTrendingCoins(List<TrendingCoinModel> coins) async {
    final String encoded = jsonEncode(
      coins.map((TrendingCoinModel c) => c.toJson()).toList(),
    );
    await trendingBox.put(_trendingKey, encoded);
  }

  @override
  Future<List<TrendingCoinModel>> getCachedTrendingCoins() async {
    final String? raw = trendingBox.get(_trendingKey);
    if (raw == null) {
      throw const CacheException('No cached trending coins');
    }
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map<TrendingCoinModel>(
          (dynamic e) => TrendingCoinModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
