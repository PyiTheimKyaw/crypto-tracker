import 'package:flutter/foundation.dart';

@immutable
class CoinDetail {
  const CoinDetail({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.marketCapRank,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.marketCap,
    required this.totalVolume,
    required this.ath,
    required this.athChangePercentage,
    required this.atl,
    required this.atlChangePercentage,
    required this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    required this.description,
    this.isFavorite = false,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final int marketCapRank;
  final double currentPrice;
  final double priceChangePercentage24h;
  final double marketCap;
  final double totalVolume;
  final double ath;
  final double athChangePercentage;
  final double atl;
  final double atlChangePercentage;
  final double circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final String description;
  final bool isFavorite;

  CoinDetail copyWith({bool? isFavorite}) {
    return CoinDetail(
      id: id,
      symbol: symbol,
      name: name,
      image: image,
      marketCapRank: marketCapRank,
      currentPrice: currentPrice,
      priceChangePercentage24h: priceChangePercentage24h,
      marketCap: marketCap,
      totalVolume: totalVolume,
      ath: ath,
      athChangePercentage: athChangePercentage,
      atl: atl,
      atlChangePercentage: atlChangePercentage,
      circulatingSupply: circulatingSupply,
      totalSupply: totalSupply,
      maxSupply: maxSupply,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoinDetail &&
          other.id == id &&
          other.symbol == symbol &&
          other.name == name &&
          other.image == image &&
          other.marketCapRank == marketCapRank &&
          other.currentPrice == currentPrice &&
          other.priceChangePercentage24h == priceChangePercentage24h &&
          other.marketCap == marketCap &&
          other.totalVolume == totalVolume &&
          other.ath == ath &&
          other.athChangePercentage == athChangePercentage &&
          other.atl == atl &&
          other.atlChangePercentage == atlChangePercentage &&
          other.circulatingSupply == circulatingSupply &&
          other.totalSupply == totalSupply &&
          other.maxSupply == maxSupply &&
          other.description == description &&
          other.isFavorite == isFavorite);

  @override
  int get hashCode => Object.hashAll(<Object?>[
    id,
    symbol,
    name,
    image,
    marketCapRank,
    currentPrice,
    priceChangePercentage24h,
    marketCap,
    totalVolume,
    ath,
    athChangePercentage,
    atl,
    atlChangePercentage,
    circulatingSupply,
    totalSupply,
    maxSupply,
    description,
    isFavorite,
  ]);
}
