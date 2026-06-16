import 'dart:convert';

import 'package:crypto_tracker/features/market/data/models/coin_model.dart';
import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String bitcoinJson = '''
{
  "id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
  "current_price": 76764.0,
  "market_cap": 1540000000000,
  "market_cap_rank": 1,
  "fully_diluted_valuation": 1611548000000,
  "total_volume": 35000000000,
  "high_24h": 77500.0,
  "low_24h": 76000.0,
  "price_change_24h": -400.0,
  "price_change_percentage_24h": -0.52,
  "last_updated": "2026-06-15T12:00:00.000Z"
}
''';

  group('CoinModel.fromJson', () {
    test('parses a CoinGecko /coins/markets item with all fields', () {
      final Map<String, dynamic> map =
          jsonDecode(bitcoinJson) as Map<String, dynamic>;

      final CoinModel model = CoinModel.fromJson(map);

      expect(model.id, 'bitcoin');
      expect(model.symbol, 'btc');
      expect(model.name, 'Bitcoin');
      expect(
        model.image,
        'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
      );
      expect(model.currentPrice, 76764.0);
      expect(model.marketCap, 1540000000000);
      expect(model.marketCapRank, 1);
      expect(model.priceChangePercentage24h, -0.52);
      expect(model.totalVolume, 35000000000);
    });

    test('applies defaults when optional numeric fields are absent', () {
      final CoinModel model = CoinModel.fromJson(<String, dynamic>{
        'id': 'newcoin',
        'symbol': 'new',
        'name': 'New Coin',
      });

      expect(model.image, '');
      expect(model.currentPrice, 0.0);
      expect(model.marketCap, 0.0);
      expect(model.marketCapRank, 0);
      expect(model.priceChangePercentage24h, 0.0);
      expect(model.totalVolume, 0.0);
    });

    test('handles integer-valued JSON numbers in double fields', () {
      final CoinModel model = CoinModel.fromJson(<String, dynamic>{
        'id': 'eth',
        'symbol': 'eth',
        'name': 'Ethereum',
        'current_price': 2096,
        'market_cap': 253150000000,
        'total_volume': 9780000000,
      });

      expect(model.currentPrice, 2096.0);
      expect(model.marketCap, 253150000000.0);
      expect(model.totalVolume, 9780000000.0);
    });
  });

  group('CoinModel.toEntity', () {
    test('maps every field 1:1 and defaults isFavorite to false', () {
      const CoinModel model = CoinModel(
        id: 'bitcoin',
        symbol: 'btc',
        name: 'Bitcoin',
        image: 'https://example.com/btc.png',
        currentPrice: 76764.0,
        marketCap: 1540000000000,
        marketCapRank: 1,
        priceChangePercentage24h: -0.52,
        totalVolume: 35000000000,
      );

      final Coin entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.symbol, model.symbol);
      expect(entity.name, model.name);
      expect(entity.image, model.image);
      expect(entity.currentPrice, model.currentPrice);
      expect(entity.marketCap, model.marketCap);
      expect(entity.marketCapRank, model.marketCapRank);
      expect(entity.priceChangePercentage24h, model.priceChangePercentage24h);
      expect(entity.totalVolume, model.totalVolume);
      expect(entity.isFavorite, isFalse);
    });

    test('honors isFavorite override when merging from favorites repo', () {
      const CoinModel model = CoinModel(
        id: 'ethereum',
        symbol: 'eth',
        name: 'Ethereum',
      );

      final Coin entity = model.toEntity(isFavorite: true);

      expect(entity.isFavorite, isTrue);
      expect(entity.id, 'ethereum');
    });
  });
}
