import 'package:flutter/foundation.dart';

@immutable
class GlobalMarket {
  const GlobalMarket({
    required this.totalMarketCapUsd,
    required this.totalVolumeUsd,
    required this.marketCapChangePercentage24hUsd,
  });

  final double totalMarketCapUsd;
  final double totalVolumeUsd;
  final double marketCapChangePercentage24hUsd;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlobalMarket &&
          other.totalMarketCapUsd == totalMarketCapUsd &&
          other.totalVolumeUsd == totalVolumeUsd &&
          other.marketCapChangePercentage24hUsd ==
              marketCapChangePercentage24hUsd);

  @override
  int get hashCode => Object.hash(
    totalMarketCapUsd,
    totalVolumeUsd,
    marketCapChangePercentage24hUsd,
  );

  @override
  String toString() =>
      'GlobalMarket(cap: $totalMarketCapUsd, vol: $totalVolumeUsd, change: $marketCapChangePercentage24hUsd%)';
}
