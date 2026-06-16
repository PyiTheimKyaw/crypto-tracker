import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/coin_detail.dart';

class MarketStatsGrid extends StatelessWidget {
  const MarketStatsGrid({super.key, required this.coin});

  final CoinDetail coin;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'MARKET STATS',
            style: AppTextStyles.sectionLabel.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _StatTile(
                  label: 'MARKET CAP',
                  value: Formatters.compactCurrency(coin.marketCap),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  label: 'VOLUME 24H',
                  value: Formatters.compactCurrency(coin.totalVolume),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _StatTile(
                  label: 'ALL-TIME HIGH',
                  value: Formatters.price(coin.ath),
                  delta: coin.athChangePercentage,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  label: 'ALL-TIME LOW',
                  value: Formatters.price(coin.atl),
                  delta: coin.atlChangePercentage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _StatTile(
                  label: 'CIRCULATING SUPPLY',
                  value:
                      Formatters.supply(coin.circulatingSupply, coin.symbol),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  label: 'MAX SUPPLY',
                  value: coin.maxSupply == null
                      ? '∞ uncapped'
                      : Formatters.supply(coin.maxSupply!, coin.symbol),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    this.delta,
  });

  final String label;
  final String value;
  final double? delta;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final double? d = delta;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: semantic.tileBackground,
        border: Border.all(color: semantic.tileBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: AppTextStyles.sectionLabel.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.statValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (d != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              Formatters.percent(d),
              style: AppTextStyles.changeBadge.copyWith(
                color: d >= 0 ? semantic.positive : semantic.negative,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
