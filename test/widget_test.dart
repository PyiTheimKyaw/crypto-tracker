import 'package:crypto_tracker/app.dart';
import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/core/providers/core_providers.dart';
import 'package:crypto_tracker/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:crypto_tracker/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/presentation/providers/market_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/market_mocks.dart';

class _MockFavorites extends Mock implements FavoritesRepository {}

void main() {
  testWidgets('Market home renders title + LIVE label', (
    WidgetTester tester,
  ) async {
    final MockMarketRepository repo = MockMarketRepository();
    when(() => repo.getCoins(page: 1)).thenAnswer(
      (_) async => const Right<Failure, List<Coin>>(<Coin>[]),
    );
    when(() => repo.getGlobalMarket()).thenAnswer(
      (_) async => const Right<Failure, GlobalMarket>(
        GlobalMarket(
          totalMarketCapUsd: 0,
          totalVolumeUsd: 0,
          marketCapChangePercentage24hUsd: 0,
        ),
      ),
    );
    when(() => repo.getTrendingCoins()).thenAnswer(
      (_) async =>
          const Right<Failure, List<TrendingCoin>>(<TrendingCoin>[]),
    );

    final _MockFavorites favs = _MockFavorites();
    when(favs.watchFavorites)
        .thenAnswer((_) => Stream<Set<String>>.value(<String>{}));
    when(favs.getFavoriteIds).thenAnswer((_) async => <String>{});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketRepositoryProvider.overrideWithValue(repo),
          favoritesRepositoryProvider.overrideWithValue(favs),
          connectivityStreamProvider.overrideWith(
            (_) => Stream<bool>.value(true),
          ),
        ],
        child: const CryptoTrackerApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Markets'), findsOneWidget);
    expect(find.textContaining('LIVE'), findsOneWidget);
  });
}
