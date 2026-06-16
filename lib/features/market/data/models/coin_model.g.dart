// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoinModel _$CoinModelFromJson(Map<String, dynamic> json) => _CoinModel(
  id: json['id'] as String,
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  image: json['image'] as String? ?? '',
  currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
  marketCap: (json['market_cap'] as num?)?.toDouble() ?? 0.0,
  marketCapRank: (json['market_cap_rank'] as num?)?.toInt() ?? 0,
  priceChangePercentage24h:
      (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
  totalVolume: (json['total_volume'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$CoinModelToJson(_CoinModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'market_cap': instance.marketCap,
      'market_cap_rank': instance.marketCapRank,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
      'total_volume': instance.totalVolume,
    };
