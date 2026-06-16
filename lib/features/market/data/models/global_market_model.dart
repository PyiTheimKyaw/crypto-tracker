import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/global_market.dart';

part 'global_market_model.freezed.dart';
part 'global_market_model.g.dart';

@freezed
abstract class GlobalMarketModel with _$GlobalMarketModel {
  const factory GlobalMarketModel({
    @JsonKey(name: 'total_market_cap')
    @Default(<String, double>{})
    Map<String, double> totalMarketCap,
    @JsonKey(name: 'total_volume')
    @Default(<String, double>{})
    Map<String, double> totalVolume,
    @JsonKey(name: 'market_cap_change_percentage_24h_usd')
    @Default(0.0)
    double marketCapChangePercentage24hUsd,
  }) = _GlobalMarketModel;

  factory GlobalMarketModel.fromJson(Map<String, dynamic> json) =>
      _$GlobalMarketModelFromJson(json);
}

extension GlobalMarketModelX on GlobalMarketModel {
  GlobalMarket toEntity() => GlobalMarket(
    totalMarketCapUsd: totalMarketCap['usd'] ?? 0.0,
    totalVolumeUsd: totalVolume['usd'] ?? 0.0,
    marketCapChangePercentage24hUsd: marketCapChangePercentage24hUsd,
  );
}
