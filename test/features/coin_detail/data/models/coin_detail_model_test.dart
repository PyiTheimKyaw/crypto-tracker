import 'dart:convert';

import 'package:crypto_tracker/features/coin_detail/data/models/coin_detail_model.dart';
import 'package:crypto_tracker/features/coin_detail/domain/entities/coin_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String ethereumJson = '''
{
  "id": "ethereum",
  "symbol": "eth",
  "name": "Ethereum",
  "market_cap_rank": 2,
  "image": {
    "thumb": "https://example.com/eth_thumb.png",
    "small": "https://example.com/eth_small.png",
    "large": "https://example.com/eth_large.png"
  },
  "description": {
    "en": "Ethereum is a decentralized computing platform that executes smart contracts."
  },
  "market_data": {
    "current_price": { "usd": 2095.85, "btc": 0.027 },
    "market_cap": { "usd": 253150000000 },
    "total_volume": { "usd": 9780000000 },
    "ath": { "usd": 4878.00 },
    "ath_change_percentage": { "usd": -57.03 },
    "atl": { "usd": 0.4300 },
    "atl_change_percentage": { "usd": 487306.98 },
    "price_change_percentage_24h": -0.13,
    "circulating_supply": 120280000,
    "total_supply": 120280000,
    "max_supply": null
  }
}
''';

  group('CoinDetailModel.fromJson', () {
    test('parses a full CoinGecko /coins/{id} payload', () {
      final Map<String, dynamic> map =
          jsonDecode(ethereumJson) as Map<String, dynamic>;

      final CoinDetailModel model = CoinDetailModel.fromJson(map);

      expect(model.id, 'ethereum');
      expect(model.symbol, 'eth');
      expect(model.name, 'Ethereum');
      expect(model.marketCapRank, 2);
      expect(model.image?.large, 'https://example.com/eth_large.png');
      expect(model.description?.en, contains('Ethereum'));
      expect(model.marketData?.currentPrice['usd'], 2095.85);
      expect(model.marketData?.priceChangePercentage24h, -0.13);
      expect(model.marketData?.maxSupply, isNull);
    });

    test('applies safe defaults when image/description/market_data missing',
        () {
      final CoinDetailModel model =
          CoinDetailModel.fromJson(<String, dynamic>{
        'id': 'shib',
        'symbol': 'shib',
        'name': 'Shiba Inu',
      });

      expect(model.image, isNull);
      expect(model.description, isNull);
      expect(model.marketData, isNull);
    });
  });

  group('CoinDetailModel.toEntity', () {
    test('flattens nested per-currency maps into USD scalars', () {
      final Map<String, dynamic> map =
          jsonDecode(ethereumJson) as Map<String, dynamic>;
      final CoinDetailModel model = CoinDetailModel.fromJson(map);

      final CoinDetail entity = model.toEntity(isFavorite: true);

      expect(entity.id, 'ethereum');
      expect(entity.symbol, 'eth');
      expect(entity.name, 'Ethereum');
      expect(entity.image, 'https://example.com/eth_large.png');
      expect(entity.marketCapRank, 2);
      expect(entity.currentPrice, 2095.85);
      expect(entity.priceChangePercentage24h, -0.13);
      expect(entity.marketCap, 253150000000);
      expect(entity.totalVolume, 9780000000);
      expect(entity.ath, 4878.00);
      expect(entity.athChangePercentage, -57.03);
      expect(entity.atl, 0.4300);
      expect(entity.atlChangePercentage, 487306.98);
      expect(entity.circulatingSupply, 120280000);
      expect(entity.totalSupply, 120280000);
      expect(entity.maxSupply, isNull);
      expect(entity.description, contains('Ethereum'));
      expect(entity.isFavorite, isTrue);
    });

    test('falls back to small image when large is empty', () {
      const CoinDetailModel model = CoinDetailModel(
        id: 'btc',
        symbol: 'btc',
        name: 'Bitcoin',
        image: CoinDetailImageModel(
          small: 'https://example.com/btc_small.png',
        ),
      );

      final CoinDetail entity = model.toEntity();

      expect(entity.image, 'https://example.com/btc_small.png');
    });

    test('zero-defaults when market_data is missing', () {
      const CoinDetailModel model = CoinDetailModel(
        id: 'shib',
        symbol: 'shib',
        name: 'Shiba Inu',
      );

      final CoinDetail entity = model.toEntity();

      expect(entity.currentPrice, 0.0);
      expect(entity.marketCap, 0.0);
      expect(entity.priceChangePercentage24h, 0.0);
      expect(entity.totalSupply, isNull);
      expect(entity.maxSupply, isNull);
      expect(entity.description, '');
    });
  });
}
