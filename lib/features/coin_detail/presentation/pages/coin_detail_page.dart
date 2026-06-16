import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../domain/entities/coin_detail.dart';
import '../providers/coin_detail_providers.dart';
import '../widgets/about_coin_section.dart';
import '../widgets/market_stats_grid.dart';
import '../widgets/price_header.dart';

class CoinDetailPage extends ConsumerWidget {
  const CoinDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CoinDetail> state = ref.watch(coinDetailProvider(id));
    final AppSemanticColors semantic = context.semantic;

    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          tooltip: l10n.back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: state.maybeWhen(
          data: (CoinDetail c) => Text(
            '${c.symbol.toUpperCase()}  ·  ${l10n.rankNumber(c.marketCapRank)}',
            style: AppTextStyles.sectionLabel.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
        actions: <Widget>[
          _FavoriteAction(id: id),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, _) => _ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(coinDetailProvider(id)),
        ),
        data: (CoinDetail coin) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(coinDetailProvider(id)),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 32),
            children: <Widget>[
              PriceHeader(coin: coin),
              MarketStatsGrid(coin: coin),
              AboutCoinSection(coin: coin),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteAction extends ConsumerWidget {
  const _FavoriteAction({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSemanticColors semantic = context.semantic;
    final AsyncValue<Set<String>> favoritesAsync =
        ref.watch(favoritesStreamProvider);
    final bool isFavorite = favoritesAsync.maybeWhen(
      data: (Set<String> ids) => ids.contains(id),
      orElse: () => false,
    );

    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: semantic.tileBackground,
          border: Border.all(color: semantic.tileBorder),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          tooltip: isFavorite ? l10n.unfavorite : l10n.favorite,
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite
                ? semantic.favoriteActive
                : semantic.favoriteInactive,
            size: 18,
          ),
          onPressed: () => _onToggle(context, ref),
        ),
      ),
    );
  }

  Future<void> _onToggle(BuildContext context, WidgetRef ref) async {
    final Either<Failure, bool> result =
        await ref.read(toggleFavoriteProvider)(id);
    if (!context.mounted) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context);
    result.match(
      (Failure failure) {
        ScaffoldMessenger.maybeOf(context)
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                l10n.favoriteUpdateFailed(failure.message),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              duration: const Duration(seconds: 3),
            ),
          );
      },
      (_) {},
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.cloud_off, size: 32, color: semantic.mutedLabel),
            const SizedBox(height: 12),
            Text(l10n.loadError, style: AppTextStyles.coinName),
            const SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(color: semantic.mutedLabel, fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}
