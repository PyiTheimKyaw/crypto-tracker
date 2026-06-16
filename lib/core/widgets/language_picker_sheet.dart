import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

void showLanguagePicker(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext _) => const LanguagePickerSheet(),
  );
}

class LanguagePickerSheet extends ConsumerWidget {
  const LanguagePickerSheet({super.key});

  static const List<_LanguageOption> _options = <_LanguageOption>[
    _LanguageOption(locale: null, label: 'System default', isSystem: true),
    _LanguageOption(locale: Locale('en'), label: 'English'),
    _LanguageOption(locale: Locale('my'), label: 'မြန်မာ'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale? current = ref.watch(localeProvider);
    final AppSemanticColors semantic = context.semantic;
    final AppLocalizations l10n = AppLocalizations.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 4),
              child: Text(
                l10n.language.toUpperCase(),
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
            ),
            ..._options.map((_LanguageOption opt) {
              final bool selected = opt.isSystem
                  ? current == null
                  : current?.languageCode == opt.locale?.languageCode;
              return _LanguageRow(
                option: opt,
                selected: selected,
                systemLabel: l10n.systemDefault,
                onTap: () => _select(context, ref, opt.locale),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _select(
    BuildContext context,
    WidgetRef ref,
    Locale? locale,
  ) async {
    await ref.read(localeProvider.notifier).setLocale(locale);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.locale,
    required this.label,
    this.isSystem = false,
  });

  final Locale? locale;
  final String label;
  final bool isSystem;
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.option,
    required this.selected,
    required this.systemLabel,
    required this.onTap,
  });

  final _LanguageOption option;
  final bool selected;
  final String systemLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? semantic.tileBackground
                : Colors.transparent,
            border: Border.all(
              color: selected ? semantic.tileBorder : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  option.isSystem ? systemLabel : option.label,
                  style: AppTextStyles.coinName,
                ),
              ),
              if (selected)
                Icon(Icons.check, color: semantic.favoriteActive, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
