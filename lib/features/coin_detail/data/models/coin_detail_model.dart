import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/coin_detail.dart';

part 'coin_detail_model.freezed.dart';
part 'coin_detail_model.g.dart';

@freezed
abstract class CoinDetailImageModel with _$CoinDetailImageModel {
  const factory CoinDetailImageModel({
    @Default('') String thumb,
    @Default('') String small,
    @Default('') String large,
  }) = _CoinDetailImageModel;

  factory CoinDetailImageModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailImageModelFromJson(json);
}

@freezed
abstract class CoinDetailDescriptionModel with _$CoinDetailDescriptionModel {
  const factory CoinDetailDescriptionModel({@Default('') String en}) =
      _CoinDetailDescriptionModel;

  factory CoinDetailDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailDescriptionModelFromJson(json);
}

@freezed
abstract class CoinDetailMarketDataModel with _$CoinDetailMarketDataModel {
  const factory CoinDetailMarketDataModel({
    @JsonKey(name: 'current_price')
    @Default(<String, double>{})
    Map<String, double> currentPrice,
    @JsonKey(name: 'market_cap')
    @Default(<String, double>{})
    Map<String, double> marketCap,
    @JsonKey(name: 'total_volume')
    @Default(<String, double>{})
    Map<String, double> totalVolume,
    @Default(<String, double>{}) Map<String, double> ath,
    @JsonKey(name: 'ath_change_percentage')
    @Default(<String, double>{})
    Map<String, double> athChangePercentage,
    @Default(<String, double>{}) Map<String, double> atl,
    @JsonKey(name: 'atl_change_percentage')
    @Default(<String, double>{})
    Map<String, double> atlChangePercentage,
    @JsonKey(name: 'price_change_percentage_24h')
    @Default(0.0)
    double priceChangePercentage24h,
    @JsonKey(name: 'circulating_supply')
    @Default(0.0)
    double circulatingSupply,
    @JsonKey(name: 'total_supply') double? totalSupply,
    @JsonKey(name: 'max_supply') double? maxSupply,
  }) = _CoinDetailMarketDataModel;

  factory CoinDetailMarketDataModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailMarketDataModelFromJson(json);
}

@freezed
abstract class CoinDetailModel with _$CoinDetailModel {
  const factory CoinDetailModel({
    required String id,
    required String symbol,
    required String name,
    @JsonKey(name: 'market_cap_rank') @Default(0) int marketCapRank,
    CoinDetailImageModel? image,
    CoinDetailDescriptionModel? description,
    @JsonKey(name: 'market_data') CoinDetailMarketDataModel? marketData,
  }) = _CoinDetailModel;

  factory CoinDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailModelFromJson(json);
}

extension CoinDetailModelX on CoinDetailModel {
  CoinDetail toEntity({bool isFavorite = false}) {
    final CoinDetailMarketDataModel? m = marketData;
    final String img = image?.large.isNotEmpty == true
        ? image!.large
        : (image?.small ?? '');
    return CoinDetail(
      id: id,
      symbol: symbol,
      name: name,
      image: img,
      marketCapRank: marketCapRank,
      currentPrice: m?.currentPrice['usd'] ?? 0.0,
      priceChangePercentage24h: m?.priceChangePercentage24h ?? 0.0,
      marketCap: m?.marketCap['usd'] ?? 0.0,
      totalVolume: m?.totalVolume['usd'] ?? 0.0,
      ath: m?.ath['usd'] ?? 0.0,
      athChangePercentage: m?.athChangePercentage['usd'] ?? 0.0,
      atl: m?.atl['usd'] ?? 0.0,
      atlChangePercentage: m?.atlChangePercentage['usd'] ?? 0.0,
      circulatingSupply: m?.circulatingSupply ?? 0.0,
      totalSupply: m?.totalSupply,
      maxSupply: m?.maxSupply,
      description: description?.en ?? '',
      isFavorite: isFavorite,
    );
  }
}
