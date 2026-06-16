import 'dart:convert';

import 'package:crypto_tracker/features/market/data/models/trending_coin_model.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String trendingEnvelope = r'''
{
  "coins": [
    {
      "item": {
        "id": "bonk",
        "coin_id": 1234,
        "name": "Bonk",
        "symbol": "BONK",
        "market_cap_rank": 102,
        "thumb": "https://example.com/bonk_thumb.png",
        "small": "https://example.com/bonk_small.png",
        "large": "https://example.com/bonk_large.png",
        "slug": "bonk",
        "price_btc": 0.0000000006,
        "score": 0,
        "data": {
          "price": 0.00000601,
          "price_btc": "0.0000000006",
          "market_cap": "$430,000,000",
          "total_volume": "$22,000,000",
          "price_change_percentage_24h": {
            "btc": 0.4,
            "usd": -1.36,
            "eth": 0.2
          },
          "sparkline": "https://example.com/sparkline.svg"
        }
      }
    }
  ],
  "nfts": [],
  "categories": []
}
''';

  group('TrendingCoinModel.fromJson', () {
    test('parses the item payload from /search/trending', () {
      final Map<String, dynamic> envelope =
          jsonDecode(trendingEnvelope) as Map<String, dynamic>;
      final List<dynamic> coins = envelope['coins'] as List<dynamic>;
      final Map<String, dynamic> firstItem =
          (coins.first as Map<String, dynamic>)['item']
              as Map<String, dynamic>;

      final TrendingCoinModel model = TrendingCoinModel.fromJson(firstItem);

      expect(model.id, 'bonk');
      expect(model.name, 'Bonk');
      expect(model.symbol, 'BONK');
      expect(model.thumb, 'https://example.com/bonk_thumb.png');
      expect(model.marketCapRank, 102);
      expect(model.data?.price, 0.00000601);
      expect(model.data?.priceChangePercentage24h['usd'], -1.36);
    });

    test('tolerates a missing data block', () {
      final TrendingCoinModel model =
          TrendingCoinModel.fromJson(<String, dynamic>{
        'id': 'pepe',
        'name': 'Pepe',
        'symbol': 'PEPE',
      });

      expect(model.thumb, '');
      expect(model.marketCapRank, 0);
      expect(model.data, isNull);
    });
  });

  group('TrendingCoinModel.toEntity', () {
    test('flattens data.price and data.price_change_percentage_24h.usd', () {
      const TrendingCoinModel model = TrendingCoinModel(
        id: 'bonk',
        name: 'Bonk',
        symbol: 'BONK',
        thumb: 'https://example.com/bonk.png',
        marketCapRank: 102,
        data: TrendingCoinDataModel(
          price: 0.00000601,
          priceChangePercentage24h: <String, double>{
            'usd': -1.36,
            'btc': 0.4,
          },
        ),
      );

      final TrendingCoin entity = model.toEntity();

      expect(entity.id, 'bonk');
      expect(entity.priceUsd, 0.00000601);
      expect(entity.priceChangePercentage24hUsd, -1.36);
      expect(entity.marketCapRank, 102);
    });

    test('defaults price + change to zero when data is null', () {
      const TrendingCoinModel model = TrendingCoinModel(
        id: 'pepe',
        name: 'Pepe',
        symbol: 'PEPE',
      );

      final TrendingCoin entity = model.toEntity();

      expect(entity.priceUsd, 0.0);
      expect(entity.priceChangePercentage24hUsd, 0.0);
    });
  });
}
