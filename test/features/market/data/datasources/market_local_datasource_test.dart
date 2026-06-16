import 'dart:convert';

import 'package:crypto_tracker/core/error/exceptions.dart';
import 'package:crypto_tracker/features/market/data/datasources/market_local_datasource.dart';
import 'package:crypto_tracker/features/market/data/models/coin_model.dart';
import 'package:crypto_tracker/features/market/data/models/global_market_model.dart';
import 'package:crypto_tracker/features/market/data/models/trending_coin_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:mocktail/mocktail.dart';

class _MockBox extends Mock implements Box<String> {}

void main() {
  late _MockBox coinsBox;
  late _MockBox globalBox;
  late _MockBox trendingBox;
  late MarketLocalDataSourceImpl source;

  setUp(() {
    coinsBox = _MockBox();
    globalBox = _MockBox();
    trendingBox = _MockBox();
    source = MarketLocalDataSourceImpl(
      coinsBox: coinsBox,
      globalBox: globalBox,
      trendingBox: trendingBox,
    );
  });

  group('coins page 1', () {
    const CoinModel tCoin = CoinModel(
      id: 'bitcoin',
      symbol: 'btc',
      name: 'Bitcoin',
      currentPrice: 76764.0,
    );

    test('cacheCoinsPage1 encodes models and writes the JSON string', () async {
      when(() => coinsBox.put(any<String>(), any<String>())).thenAnswer((_) async {});

      await source.cacheCoinsPage1(<CoinModel>[tCoin]);

      final VerificationResult capture =
          verify(() => coinsBox.put('page_1', captureAny<String>()))..called(1);
      final String written = capture.captured.single as String;
      final List<dynamic> decoded = jsonDecode(written) as List<dynamic>;
      expect(decoded, hasLength(1));
      expect((decoded.first as Map<String, dynamic>)['id'], 'bitcoin');
    });

    test('getCachedCoinsPage1 decodes the JSON back into models', () async {
      final String stored = jsonEncode(<Map<String, dynamic>>[tCoin.toJson()]);
      when(() => coinsBox.get('page_1')).thenReturn(stored);

      final List<CoinModel> result = await source.getCachedCoinsPage1();

      expect(result, hasLength(1));
      expect(result.first, tCoin);
    });

    test('getCachedCoinsPage1 throws CacheException on miss', () async {
      when(() => coinsBox.get('page_1')).thenReturn(null);

      expect(
        () => source.getCachedCoinsPage1(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('global market', () {
    const GlobalMarketModel tGlobal = GlobalMarketModel(
      totalMarketCap: <String, double>{'usd': 2440000000000},
      totalVolume: <String, double>{'usd': 93220000000},
      marketCapChangePercentage24hUsd: -0.42,
    );

    test('cacheGlobalMarket writes the encoded JSON', () async {
      when(() => globalBox.put(any<String>(), any<String>())).thenAnswer((_) async {});

      await source.cacheGlobalMarket(tGlobal);

      final VerificationResult capture =
          verify(() => globalBox.put('data', captureAny<String>()))..called(1);
      final Map<String, dynamic> decoded =
          jsonDecode(capture.captured.single as String) as Map<String, dynamic>;
      expect(
        (decoded['total_market_cap'] as Map<String, dynamic>)['usd'],
        2440000000000,
      );
    });

    test('getCachedGlobalMarket decodes back into the model', () async {
      when(() => globalBox.get('data'))
          .thenReturn(jsonEncode(tGlobal.toJson()));

      final GlobalMarketModel result = await source.getCachedGlobalMarket();

      expect(result, tGlobal);
    });

    test('getCachedGlobalMarket throws CacheException on miss', () async {
      when(() => globalBox.get('data')).thenReturn(null);

      expect(
        () => source.getCachedGlobalMarket(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('trending coins', () {
    const TrendingCoinModel tTrending = TrendingCoinModel(
      id: 'bonk',
      name: 'Bonk',
      symbol: 'BONK',
      thumb: 'https://example.com/bonk.png',
      marketCapRank: 102,
      data: TrendingCoinDataModel(
        price: 0.00000601,
        priceChangePercentage24h: <String, double>{'usd': -1.36},
      ),
    );

    test('cacheTrendingCoins writes the encoded JSON list', () async {
      when(() => trendingBox.put(any<String>(), any<String>())).thenAnswer((_) async {});

      await source.cacheTrendingCoins(<TrendingCoinModel>[tTrending]);

      final VerificationResult capture =
          verify(() => trendingBox.put('data', captureAny<String>()))
            ..called(1);
      final List<dynamic> decoded =
          jsonDecode(capture.captured.single as String) as List<dynamic>;
      expect(decoded, hasLength(1));
      expect((decoded.first as Map<String, dynamic>)['id'], 'bonk');
    });

    test('getCachedTrendingCoins decodes back into models', () async {
      final String stored =
          jsonEncode(<Map<String, dynamic>>[tTrending.toJson()]);
      when(() => trendingBox.get('data')).thenReturn(stored);

      final List<TrendingCoinModel> result =
          await source.getCachedTrendingCoins();

      expect(result, hasLength(1));
      expect(result.first.id, 'bonk');
      expect(result.first.data?.priceChangePercentage24h['usd'], -1.36);
    });

    test('getCachedTrendingCoins throws CacheException on miss', () async {
      when(() => trendingBox.get('data')).thenReturn(null);

      expect(
        () => source.getCachedTrendingCoins(),
        throwsA(isA<CacheException>()),
      );
    });
  });
}
