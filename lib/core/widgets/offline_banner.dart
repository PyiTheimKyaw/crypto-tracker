import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';
import '../providers/core_providers.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<bool> state = ref.watch(connectivityStreamProvider);
    final bool offline = state.maybeWhen(
      data: (bool online) => !online,
      orElse: () => false,
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: offline
          ? const _OfflineBar(key: ValueKey<String>('offline'))
          : const SizedBox.shrink(key: ValueKey<String>('online')),
    );
  }
}

class _OfflineBar extends StatelessWidget {
  const _OfflineBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Material(
      color: semantic.negativeSoft,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              Icon(Icons.cloud_off, size: 14, color: semantic.negative),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.noInternet,
                  style: AppTextStyles.sectionLabel.copyWith(
                    color: semantic.negative,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Text(
                'CACHED',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.negative,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
