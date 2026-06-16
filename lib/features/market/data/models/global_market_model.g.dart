// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlobalMarketModel _$GlobalMarketModelFromJson(Map<String, dynamic> json) =>
    _GlobalMarketModel(
      totalMarketCap:
          (json['total_market_cap'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const <String, double>{},
      totalVolume:
          (json['total_volume'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const <String, double>{},
      marketCapChangePercentage24hUsd:
          (json['market_cap_change_percentage_24h_usd'] as num?)?.toDouble() ??
          0.0,
    );

Map<String, dynamic> _$GlobalMarketModelToJson(_GlobalMarketModel instance) =>
    <String, dynamic>{
      'total_market_cap': instance.totalMarketCap,
      'total_volume': instance.totalVolume,
      'market_cap_change_percentage_24h_usd':
          instance.marketCapChangePercentage24hUsd,
    };
