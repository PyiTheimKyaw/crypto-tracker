import 'package:flutter/foundation.dart';

@immutable
class TrendingCoin {
  const TrendingCoin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
    required this.marketCapRank,
    required this.priceUsd,
    required this.priceChangePercentage24hUsd,
  });

  final String id;
  final String name;
  final String symbol;
  final String thumb;
  final int marketCapRank;
  final double priceUsd;
  final double priceChangePercentage24hUsd;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrendingCoin &&
          other.id == id &&
          other.name == name &&
          other.symbol == symbol &&
          other.thumb == thumb &&
          other.marketCapRank == marketCapRank &&
          other.priceUsd == priceUsd &&
          other.priceChangePercentage24hUsd == priceChangePercentage24hUsd);

  @override
  int get hashCode => Object.hash(
    id,
    name,
    symbol,
    thumb,
    marketCapRank,
    priceUsd,
    priceChangePercentage24hUsd,
  );

  @override
  String toString() =>
      'TrendingCoin(id: $id, symbol: $symbol, rank: $marketCapRank, price: $priceUsd)';
}
