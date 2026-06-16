import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/trending_coin.dart';

part 'trending_coin_model.freezed.dart';
part 'trending_coin_model.g.dart';

@freezed
abstract class TrendingCoinDataModel with _$TrendingCoinDataModel {
  const factory TrendingCoinDataModel({
    @Default(0.0) double price,
    @JsonKey(name: 'price_change_percentage_24h')
    @Default(<String, double>{})
    Map<String, double> priceChangePercentage24h,
  }) = _TrendingCoinDataModel;

  factory TrendingCoinDataModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinDataModelFromJson(json);
}

@freezed
abstract class TrendingCoinModel with _$TrendingCoinModel {
  const factory TrendingCoinModel({
    required String id,
    required String name,
    required String symbol,
    @Default('') String thumb,
    @JsonKey(name: 'market_cap_rank') @Default(0) int marketCapRank,
    TrendingCoinDataModel? data,
  }) = _TrendingCoinModel;

  factory TrendingCoinModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinModelFromJson(json);
}

extension TrendingCoinModelX on TrendingCoinModel {
  TrendingCoin toEntity() => TrendingCoin(
    id: id,
    name: name,
    symbol: symbol,
    thumb: thumb,
    marketCapRank: marketCapRank,
    priceUsd: data?.price ?? 0.0,
    priceChangePercentage24hUsd: data?.priceChangePercentage24h['usd'] ?? 0.0,
  );
}
