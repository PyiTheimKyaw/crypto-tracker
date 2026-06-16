import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../routing/app_router.dart';
import '../../domain/entities/coin.dart';
import '../providers/coin_list_notifier.dart';
import '../widgets/coin_list_item.dart';
import '../providers/global_market_provider.dart';
import '../providers/trending_provider.dart';
import '../widgets/coin_search_bar.dart';
import '../widgets/global_market_header.dart';
import '../widgets/trending_carousel.dart';

class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }
    final double offset = _scroll.position.pixels;
    final double max = _scroll.position.maxScrollExtent;
    if (max - offset < 240) {
      final CoinListState? current = ref.read(coinListProvider).value;
      if (current == null || current.paginationError != null) {
        return;
      }
      ref.read(coinListProvider.notifier).loadNextPage();
    }
  }

  Future<void> _onRefresh() async {
    ref.invalidate(globalMarketProvider);
    ref.invalidate(trendingProvider);
    await ref.read(coinListProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<CoinListState> coinState = ref.watch(coinListProvider);
    final AppSemanticColors semantic = context.semantic;

    ref.listen<AsyncValue<CoinListState>>(coinListProvider, (
      AsyncValue<CoinListState>? prev,
      AsyncValue<CoinListState> next,
    ) {
      final Failure? prevErr = prev?.value?.refreshError;
      final Failure? nextErr = next.value?.refreshError;
      if (nextErr != null && nextErr != prevErr) {
        final ScaffoldMessengerState? messenger =
            ScaffoldMessenger.maybeOf(context);
        final AppLocalizations l10n = AppLocalizations.of(context);
        messenger?.hideCurrentSnackBar();
        messenger?.showSnackBar(
          SnackBar(
            content: Text(
              l10n.refreshFailed(nextErr.message),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return Scaffold(
      appBar: _buildAppBar(context, semantic),
      body: Column(
        children: <Widget>[
          const OfflineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: CustomScrollView(
                controller: _scroll,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  const SliverToBoxAdapter(child: GlobalMarketHeader()),
                  const SliverToBoxAdapter(child: TrendingCarousel()),
                  const SliverToBoxAdapter(child: CoinSearchBar()),
                  SliverToBoxAdapter(child: _listHeader(context, semantic)),
                  _buildCoinSliver(coinState),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppSemanticColors semantic,
  ) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppBar(
      titleSpacing: 20,
      toolbarHeight: 88,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.circle, size: 6, color: semantic.mutedLabel),
              const SizedBox(width: 6),
              Text(
                l10n.liveCoingecko,
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(l10n.markets, style: AppTextStyles.pageTitle),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: semantic.tileBackground,
              border: Border.all(color: semantic.tileBorder),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.more_horiz, size: 18, color: semantic.mutedLabel),
          ),
        ),
      ],
    );
  }

  Widget _listHeader(BuildContext context, AppSemanticColors semantic) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: <Widget>[
          Text(
            l10n.assetHeader,
            style: AppTextStyles.sectionLabel.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
          const Spacer(),
          Text(
            l10n.priceHeader,
            style: AppTextStyles.sectionLabel.copyWith(
              color: semantic.mutedLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinSliver(AsyncValue<CoinListState> state) {
    return state.when(
      skipError: true,
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: MarketLoadingView(),
      ),
      error: (Object e, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: _ErrorView(
          message: e.toString(),
          onRetry: () =>
              ref.read(coinListProvider.notifier).refresh(),
        ),
      ),
      data: (CoinListState s) {
        final List<Coin> visible = s.filteredCoins;
        if (visible.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyView(query: s.query),
          );
        }
        final bool showTail = s.query.isEmpty &&
            (s.hasMore || s.paginationError != null);
        return SliverList.builder(
          itemCount: visible.length + (showTail ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index >= visible.length) {
              if (s.paginationError != null) {
                return _PaginationErrorTail(
                  message: s.paginationError!.message,
                  onRetry: () =>
                      ref.read(coinListProvider.notifier).loadNextPage(),
                );
              }
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final Coin coin = visible[index];
            return CoinListItem(
              coin: coin,
              onTap: () =>
                  context.push(AppRoutes.coinDetailPath(coin.id)),
            );
          },
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppSemanticColors semantic = context.semantic;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.cloud_off, size: 32, color: semantic.mutedLabel),
          const SizedBox(height: 12),
          Text(
            l10n.loadError,
            style: AppTextStyles.coinName,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(color: semantic.mutedLabel, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}

class _PaginationErrorTail extends StatelessWidget {
  const _PaginationErrorTail({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: <Widget>[
          Icon(Icons.error_outline, size: 18, color: semantic.negative),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: semantic.mutedLabel, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context).retry),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppSemanticColors semantic = context.semantic;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search_off, size: 32, color: semantic.mutedLabel),
            const SizedBox(height: 12),
            Text(
              query.isEmpty
                  ? l10n.noResults
                  : l10n.noResultsForQuery(query),
              style: TextStyle(color: semantic.mutedLabel),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

