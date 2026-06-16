import 'dart:convert';

import 'package:crypto_tracker/features/market/data/models/global_market_model.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String globalEnvelope = '''
{
  "data": {
    "active_cryptocurrencies": 12345,
    "markets": 1042,
    "total_market_cap": {
      "btc": 31250000,
      "eth": 1162000000,
      "usd": 2440000000000
    },
    "total_volume": {
      "btc": 1200000,
      "usd": 93220000000
    },
    "market_cap_percentage": {
      "btc": 52.5,
      "eth": 16.4
    },
    "market_cap_change_percentage_24h_usd": -0.42,
    "updated_at": 1734268800
  }
}
''';

  group('GlobalMarketModel.fromJson', () {
    test('parses the inner data object from /global envelope', () {
      final Map<String, dynamic> envelope =
          jsonDecode(globalEnvelope) as Map<String, dynamic>;
      final Map<String, dynamic> data =
          envelope['data'] as Map<String, dynamic>;

      final GlobalMarketModel model = GlobalMarketModel.fromJson(data);

      expect(model.totalMarketCap['usd'], 2440000000000);
      expect(model.totalVolume['usd'], 93220000000);
      expect(model.marketCapChangePercentage24hUsd, -0.42);
    });

    test('applies defaults for missing maps and change percentage', () {
      final GlobalMarketModel model =
          GlobalMarketModel.fromJson(<String, dynamic>{});

      expect(model.totalMarketCap, <String, double>{});
      expect(model.totalVolume, <String, double>{});
      expect(model.marketCapChangePercentage24hUsd, 0.0);
    });
  });

  group('GlobalMarketModel.toEntity', () {
    test('extracts USD values from map fields', () {
      const GlobalMarketModel model = GlobalMarketModel(
        totalMarketCap: <String, double>{'usd': 2440000000000, 'btc': 31250000},
        totalVolume: <String, double>{'usd': 93220000000},
        marketCapChangePercentage24hUsd: -0.42,
      );

      final GlobalMarket entity = model.toEntity();

      expect(entity.totalMarketCapUsd, 2440000000000);
      expect(entity.totalVolumeUsd, 93220000000);
      expect(entity.marketCapChangePercentage24hUsd, -0.42);
    });

    test('defaults USD totals to zero when the map lacks a usd key', () {
      const GlobalMarketModel model = GlobalMarketModel(
        totalMarketCap: <String, double>{'btc': 100},
        totalVolume: <String, double>{'eth': 50},
      );

      final GlobalMarket entity = model.toEntity();

      expect(entity.totalMarketCapUsd, 0.0);
      expect(entity.totalVolumeUsd, 0.0);
      expect(entity.marketCapChangePercentage24hUsd, 0.0);
    });
  });
}
