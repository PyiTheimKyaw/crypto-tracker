import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/coin_detail.dart';

class AboutCoinSection extends StatelessWidget {
  const AboutCoinSection({super.key, required this.coin});

  final CoinDetail coin;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String description = _firstSentences(coin.description, maxChars: 360);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            l10n.aboutCoin(coin.name.toUpperCase()),
            style: AppTextStyles.sectionLabel.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description.isEmpty ? '—' : description,
            style: AppTextStyles.bodyDescription.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Icon(Icons.circle, size: 6, color: semantic.mutedLabel),
              const SizedBox(width: 6),
              Text(
                l10n.sourceCoingecko,
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _firstSentences(String raw, {required int maxChars}) {
    if (raw.isEmpty) {
      return '';
    }
    final String cleaned =
        raw.replaceAll(RegExp(r'<[^>]+>'), '').replaceAll('\r', '').trim();
    if (cleaned.length <= maxChars) {
      return cleaned;
    }
    final int cut = cleaned.lastIndexOf('. ', maxChars);
    if (cut <= 0) {
      return '${cleaned.substring(0, maxChars).trim()}…';
    }
    return cleaned.substring(0, cut + 1);
  }
}
