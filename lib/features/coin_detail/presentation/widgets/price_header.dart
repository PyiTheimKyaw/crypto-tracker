import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/coin_detail.dart';

class PriceHeader extends StatelessWidget {
  const PriceHeader({super.key, required this.coin});

  final CoinDetail coin;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final bool positive = coin.priceChangePercentage24h >= 0;
    final Color changeColor =
        positive ? semantic.positive : semantic.negative;
    final Color changeBg =
        positive ? semantic.positiveSoft : semantic.negativeSoft;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _CoinAvatar(url: coin.image, symbol: coin.symbol, size: 44),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  coin.name.toUpperCase(),
                  style: AppTextStyles.sectionLabel.copyWith(
                    color: semantic.mutedLabel,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  Formatters.price(coin.currentPrice),
                  style: AppTextStyles.priceLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: changeBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            positive
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: changeColor,
                            size: 16,
                          ),
                          Text(
                            Formatters.percent(coin.priceChangePercentage24h),
                            style: AppTextStyles.changeBadge.copyWith(
                              color: changeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '24h',
                      style: AppTextStyles.coinSubtitle.copyWith(
                        color: semantic.mutedLabel,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinAvatar extends StatelessWidget {
  const _CoinAvatar({
    required this.url,
    required this.symbol,
    required this.size,
  });

  final String url;
  final String symbol;
  final double size;

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    Widget fallback() => Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: semantic.tileBorder,
        shape: BoxShape.circle,
      ),
      child: Text(
        symbol.isEmpty ? '?' : symbol.substring(0, 1).toUpperCase(),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
    if (url.isEmpty) {
      return fallback();
    }
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => fallback(),
        errorWidget: (_, _, _) => fallback(),
      ),
    );
  }
}
