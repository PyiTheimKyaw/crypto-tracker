// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoinDetailImageModel _$CoinDetailImageModelFromJson(
  Map<String, dynamic> json,
) => _CoinDetailImageModel(
  thumb: json['thumb'] as String? ?? '',
  small: json['small'] as String? ?? '',
  large: json['large'] as String? ?? '',
);

Map<String, dynamic> _$CoinDetailImageModelToJson(
  _CoinDetailImageModel instance,
) => <String, dynamic>{
  'thumb': instance.thumb,
  'small': instance.small,
  'large': instance.large,
};

_CoinDetailDescriptionModel _$CoinDetailDescriptionModelFromJson(
  Map<String, dynamic> json,
) => _CoinDetailDescriptionModel(en: json['en'] as String? ?? '');

Map<String, dynamic> _$CoinDetailDescriptionModelToJson(
  _CoinDetailDescriptionModel instance,
) => <String, dynamic>{'en': instance.en};

_CoinDetailMarketDataModel _$CoinDetailMarketDataModelFromJson(
  Map<String, dynamic> json,
) => _CoinDetailMarketDataModel(
  currentPrice:
      (json['current_price'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  marketCap:
      (json['market_cap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  totalVolume:
      (json['total_volume'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  ath:
      (json['ath'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  athChangePercentage:
      (json['ath_change_percentage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  atl:
      (json['atl'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  atlChangePercentage:
      (json['atl_change_percentage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  priceChangePercentage24h:
      (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
  circulatingSupply: (json['circulating_supply'] as num?)?.toDouble() ?? 0.0,
  totalSupply: (json['total_supply'] as num?)?.toDouble(),
  maxSupply: (json['max_supply'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CoinDetailMarketDataModelToJson(
  _CoinDetailMarketDataModel instance,
) => <String, dynamic>{
  'current_price': instance.currentPrice,
  'market_cap': instance.marketCap,
  'total_volume': instance.totalVolume,
  'ath': instance.ath,
  'ath_change_percentage': instance.athChangePercentage,
  'atl': instance.atl,
  'atl_change_percentage': instance.atlChangePercentage,
  'price_change_percentage_24h': instance.priceChangePercentage24h,
  'circulating_supply': instance.circulatingSupply,
  'total_supply': instance.totalSupply,
  'max_supply': instance.maxSupply,
};

_CoinDetailModel _$CoinDetailModelFromJson(Map<String, dynamic> json) =>
    _CoinDetailModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      marketCapRank: (json['market_cap_rank'] as num?)?.toInt() ?? 0,
      image: json['image'] == null
          ? null
          : CoinDetailImageModel.fromJson(
              json['image'] as Map<String, dynamic>,
            ),
      description: json['description'] == null
          ? null
          : CoinDetailDescriptionModel.fromJson(
              json['description'] as Map<String, dynamic>,
            ),
      marketData: json['market_data'] == null
          ? null
          : CoinDetailMarketDataModel.fromJson(
              json['market_data'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CoinDetailModelToJson(_CoinDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'market_cap_rank': instance.marketCapRank,
      'image': instance.image,
      'description': instance.description,
      'market_data': instance.marketData,
    };
