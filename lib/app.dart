import 'package:flutter/material.dart';

import 'core/theme/app_text_styles.dart';
import 'core/theme/app_theme.dart';

class CryptoTrackerApp extends StatelessWidget {
  const CryptoTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const _ThemePreviewScreen(),
    );
  }
}

class _ThemePreviewScreen extends StatelessWidget {
  const _ThemePreviewScreen();

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Tracker'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'LIVE · COINGECKO',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Markets', style: AppTextStyles.pageTitle),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: semantic.tileBackground,
                  border: Border.all(color: semantic.tileBorder),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _StatBlock(
                        label: 'TOP 20 · 24H',
                        value: r'$2.44T',
                        delta: '-0.42%',
                        deltaColor: semantic.negative,
                        deltaBg: semantic.negativeSoft,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatBlock(
                        label: 'VOL 24H',
                        value: r'$93.22B',
                        delta: '+1.20%',
                        deltaColor: semantic.positive,
                        deltaBg: semantic.positiveSoft,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 18,
                    color: semantic.favoriteActive,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.star_border,
                    size: 18,
                    color: semantic.favoriteInactive,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Surface: ',
                    style: TextStyle(color: semantic.mutedLabel),
                  ),
                  Text(
                    '0x${scheme.surface.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({
    required this.label,
    required this.value,
    required this.delta,
    required this.deltaColor,
    required this.deltaBg,
  });

  final String label;
  final String value;
  final String delta;
  final Color deltaColor;
  final Color deltaBg;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.sectionLabel.copyWith(
            color: semantic.mutedLabel,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            Text(value, style: AppTextStyles.priceSmall),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: deltaBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                delta,
                style: AppTextStyles.changeBadge.copyWith(color: deltaColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
