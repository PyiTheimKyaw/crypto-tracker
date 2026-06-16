import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/coin_list_notifier.dart';

class CoinSearchBar extends ConsumerStatefulWidget {
  const CoinSearchBar({super.key});

  @override
  ConsumerState<CoinSearchBar> createState() => _CoinSearchBarState();
}

class _CoinSearchBarState extends ConsumerState<CoinSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    ref.read(coinListProvider.notifier).search(value);
  }

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: semantic.tileBackground,
          border: Border.all(color: semantic.tileBorder),
          borderRadius: BorderRadius.circular(28),
        ),
        child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onChanged: _onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon: Icon(
              Icons.search,
              size: 18,
              color: semantic.mutedLabel,
            ),
            hintText: l10n.searchCoins,
            hintStyle: TextStyle(color: semantic.mutedLabel),
          ),
        ),
      ),
    );
  }
}
