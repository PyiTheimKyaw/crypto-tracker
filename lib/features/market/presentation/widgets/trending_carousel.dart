import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/trending_coin.dart';
import '../providers/trending_provider.dart';

class TrendingCarousel extends ConsumerWidget {
  const TrendingCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TrendingCoin>> state = ref.watch(trendingProvider);
    final AppSemanticColors semantic = context.semantic;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'TRENDING · 24H',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
              const Spacer(),
              state.maybeWhen(
                data: (List<TrendingCoin> list) => Text(
                  '${list.length} COINS  →',
                  style: AppTextStyles.sectionLabel.copyWith(
                    color: semantic.mutedLabel,
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 96,
            child: state.when(
              loading: () => const _CarouselSkeleton(),
              error: (_, _) => const SizedBox.shrink(),
              data: (List<TrendingCoin> coins) => ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: coins.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int i) =>
                    _TrendingCard(coin: coins[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.coin});

  final TrendingCoin coin;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: semantic.tileBackground,
        border: Border.all(color: semantic.tileBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _CoinThumb(url: coin.thumb, fallbackLetter: coin.symbol),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      coin.symbol.toUpperCase(),
                      style: AppTextStyles.coinName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      coin.name,
                      style: AppTextStyles.coinSubtitle.copyWith(
                        color: semantic.mutedLabel,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '#${coin.marketCapRank}',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  Formatters.price(coin.priceUsd),
                  style: AppTextStyles.priceSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              _ChangePill(value: coin.priceChangePercentage24hUsd),
            ],
          ),
        ],
      ),
    );
  }
}

class _CoinThumb extends StatelessWidget {
  const _CoinThumb({required this.url, required this.fallbackLetter});

  final String url;
  final String fallbackLetter;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _LetterAvatar(letter: fallbackLetter);
    }
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: 28,
        height: 28,
        fit: BoxFit.cover,
        placeholder: (_, _) => _LetterAvatar(letter: fallbackLetter),
        errorWidget: (_, _, _) => _LetterAvatar(letter: fallbackLetter),
      ),
    );
  }
}

class _LetterAvatar extends StatelessWidget {
  const _LetterAvatar({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: semantic.tileBorder,
        shape: BoxShape.circle,
      ),
      child: Text(
        letter.isEmpty ? '?' : letter.substring(0, 1).toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ChangePill extends StatelessWidget {
  const _ChangePill({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final bool positive = value >= 0;
    final Color color = positive ? semantic.positive : semantic.negative;
    final Color bg = positive ? semantic.positiveSoft : semantic.negativeSoft;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        Formatters.percent(value),
        style: AppTextStyles.changeBadge.copyWith(color: color),
      ),
    );
  }
}

class _CarouselSkeleton extends StatelessWidget {
  const _CarouselSkeleton();

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(width: 10),
      itemBuilder: (_, _) => Container(
        width: 200,
        decoration: BoxDecoration(
          color: semantic.tileBackground,
          border: Border.all(color: semantic.tileBorder),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
