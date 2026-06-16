import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../domain/entities/coin.dart';

class CoinListItem extends ConsumerWidget {
  const CoinListItem({super.key, required this.coin, this.onTap});

  final Coin coin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSemanticColors semantic = context.semantic;
    final bool positive = coin.priceChangePercentage24h >= 0;
    final Color changeColor =
        positive ? semantic.positive : semantic.negative;
    final Color changeBg =
        positive ? semantic.positiveSoft : semantic.negativeSoft;

    final AsyncValue<Set<String>> favoritesAsync =
        ref.watch(favoritesStreamProvider);
    final bool isFavorite = favoritesAsync.maybeWhen(
      data: (Set<String> ids) => ids.contains(coin.id),
      orElse: () => coin.isFavorite,
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 22,
              child: Text(
                '${coin.marketCapRank}',
                style: AppTextStyles.coinSubtitle.copyWith(
                  color: semantic.mutedLabel,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _CoinAvatar(url: coin.image, symbol: coin.symbol),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(coin.name, style: AppTextStyles.coinName),
                  const SizedBox(height: 2),
                  Text(
                    '${coin.symbol.toUpperCase()}  ·  ${Formatters.marketCapSubtitle(coin.marketCap)}',
                    style: AppTextStyles.coinSubtitle.copyWith(
                      color: semantic.mutedLabel,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: isFavorite ? 'Unfavorite' : 'Favorite',
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite
                    ? semantic.favoriteActive
                    : semantic.favoriteInactive,
                size: 20,
              ),
              onPressed: () => _onToggle(context, ref),
            ),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  Formatters.price(coin.currentPrice),
                  style: AppTextStyles.priceSmall,
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: changeBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    Formatters.percent(coin.priceChangePercentage24h),
                    style:
                        AppTextStyles.changeBadge.copyWith(color: changeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onToggle(BuildContext context, WidgetRef ref) async {
    final Either<Failure, bool> result =
        await ref.read(toggleFavoriteProvider)(coin.id);
    if (!context.mounted) {
      return;
    }
    result.match(
      (Failure failure) {
        ScaffoldMessenger.maybeOf(context)
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Could not update favorite: ${failure.message}',
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

class _CoinAvatar extends StatelessWidget {
  const _CoinAvatar({required this.url, required this.symbol});

  final String url;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _LetterAvatar(letter: symbol);
    }
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        placeholder: (_, _) => _LetterAvatar(letter: symbol),
        errorWidget: (_, _, _) => _LetterAvatar(letter: symbol),
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
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: semantic.tileBorder,
        shape: BoxShape.circle,
      ),
      child: Text(
        letter.isEmpty ? '?' : letter.substring(0, 1).toUpperCase(),
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }
}
