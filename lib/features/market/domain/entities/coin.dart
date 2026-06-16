import 'package:flutter/foundation.dart';

@immutable
class Coin {
  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
    required this.totalVolume,
    this.isFavorite = false,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double priceChangePercentage24h;
  final double totalVolume;
  final bool isFavorite;

  Coin copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    double? marketCap,
    int? marketCapRank,
    double? priceChangePercentage24h,
    double? totalVolume,
    bool? isFavorite,
  }) {
    return Coin(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
      totalVolume: totalVolume ?? this.totalVolume,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Coin &&
          other.id == id &&
          other.symbol == symbol &&
          other.name == name &&
          other.image == image &&
          other.currentPrice == currentPrice &&
          other.marketCap == marketCap &&
          other.marketCapRank == marketCapRank &&
          other.priceChangePercentage24h == priceChangePercentage24h &&
          other.totalVolume == totalVolume &&
          other.isFavorite == isFavorite);

  @override
  int get hashCode => Object.hash(
    id,
    symbol,
    name,
    image,
    currentPrice,
    marketCap,
    marketCapRank,
    priceChangePercentage24h,
    totalVolume,
    isFavorite,
  );

  @override
  String toString() =>
      'Coin(id: $id, symbol: $symbol, rank: $marketCapRank, price: $currentPrice, fav: $isFavorite)';
}
