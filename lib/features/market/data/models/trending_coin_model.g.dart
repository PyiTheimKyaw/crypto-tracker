// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrendingCoinDataModel _$TrendingCoinDataModelFromJson(
  Map<String, dynamic> json,
) => _TrendingCoinDataModel(
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  priceChangePercentage24h:
      (json['price_change_percentage_24h'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
);

Map<String, dynamic> _$TrendingCoinDataModelToJson(
  _TrendingCoinDataModel instance,
) => <String, dynamic>{
  'price': instance.price,
  'price_change_percentage_24h': instance.priceChangePercentage24h,
};

_TrendingCoinModel _$TrendingCoinModelFromJson(Map<String, dynamic> json) =>
    _TrendingCoinModel(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      thumb: json['thumb'] as String? ?? '',
      marketCapRank: (json['market_cap_rank'] as num?)?.toInt() ?? 0,
      data: json['data'] == null
          ? null
          : TrendingCoinDataModel.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TrendingCoinModelToJson(_TrendingCoinModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'thumb': instance.thumb,
      'market_cap_rank': instance.marketCapRank,
      'data': instance.data,
    };
