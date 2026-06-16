import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/global_market.dart';
import '../providers/global_market_provider.dart';

class GlobalMarketHeader extends ConsumerWidget {
  const GlobalMarketHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GlobalMarket> state = ref.watch(globalMarketProvider);
    return state.when(
      loading: _shell,
      error: (_, _) => const SizedBox.shrink(),
      data: _body,
    );
  }

  Widget _shell() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _body(GlobalMarket data) {
    return Builder(
      builder: (BuildContext context) {
        final AppSemanticColors semantic = context.semantic;
        final AppLocalizations l10n = AppLocalizations.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: semantic.tileBackground,
              border: Border.all(color: semantic.tileBorder),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        l10n.top20Day,
                        style: AppTextStyles.sectionLabel.copyWith(
                          color: semantic.mutedLabel,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          Text(
                            Formatters.compactCurrency(data.totalMarketCapUsd),
                            style: AppTextStyles.priceSmall,
                          ),
                          const SizedBox(width: 8),
                          _PercentBadge(
                            value: data.marketCapChangePercentage24hUsd,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 36,
                  color: semantic.tileBorder,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      l10n.volumeShort,
                      style: AppTextStyles.sectionLabel.copyWith(
                        color: semantic.mutedLabel,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      Formatters.compactCurrency(data.totalVolumeUsd),
                      style: AppTextStyles.priceSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PercentBadge extends StatelessWidget {
  const _PercentBadge({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final bool positive = value >= 0;
    return Text(
      Formatters.percent(value),
      style: AppTextStyles.changeBadge.copyWith(
        color: positive ? semantic.positive : semantic.negative,
      ),
    );
  }
}
