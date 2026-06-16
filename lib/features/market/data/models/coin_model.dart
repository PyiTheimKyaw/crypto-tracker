import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/coin.dart';

part 'coin_model.freezed.dart';
part 'coin_model.g.dart';

@freezed
abstract class CoinModel with _$CoinModel {
  const factory CoinModel({
    required String id,
    required String symbol,
    required String name,
    @Default('') String image,
    @JsonKey(name: 'current_price') @Default(0.0) double currentPrice,
    @JsonKey(name: 'market_cap') @Default(0.0) double marketCap,
    @JsonKey(name: 'market_cap_rank') @Default(0) int marketCapRank,
    @JsonKey(name: 'price_change_percentage_24h')
    @Default(0.0)
    double priceChangePercentage24h,
    @JsonKey(name: 'total_volume') @Default(0.0) double totalVolume,
  }) = _CoinModel;

  factory CoinModel.fromJson(Map<String, dynamic> json) =>
      _$CoinModelFromJson(json);
}

extension CoinModelX on CoinModel {
  Coin toEntity({bool isFavorite = false}) => Coin(
    id: id,
    symbol: symbol,
    name: name,
    image: image,
    currentPrice: currentPrice,
    marketCap: marketCap,
    marketCapRank: marketCapRank,
    priceChangePercentage24h: priceChangePercentage24h,
    totalVolume: totalVolume,
    isFavorite: isFavorite,
  );
}
