import 'dart:async';

import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/core/l10n/generated/app_localizations.dart';
import 'package:crypto_tracker/core/theme/app_theme.dart';
import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/presentation/pages/market_page.dart';
import 'package:crypto_tracker/features/market/presentation/providers/market_providers.dart';
import 'package:crypto_tracker/features/market/presentation/widgets/coin_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/market_mocks.dart';

const Coin _btc = Coin(
  id: 'bitcoin',
  symbol: 'btc',
  name: 'Bitcoin',
  image: '',
  currentPrice: 76764.00,
  marketCap: 1540000000000,
  marketCapRank: 1,
  priceChangePercentage24h: -0.52,
  totalVolume: 35000000000,
);

const Coin _eth = Coin(
  id: 'ethereum',
  symbol: 'eth',
  name: 'Ethereum',
  image: '',
  currentPrice: 2095.85,
  marketCap: 253150000000,
  marketCapRank: 2,
  priceChangePercentage24h: -0.13,
  totalVolume: 9780000000,
);

const GlobalMarket _emptyGlobal = GlobalMarket(
  totalMarketCapUsd: 0,
  totalVolumeUsd: 0,
  marketCapChangePercentage24hUsd: 0,
);

Widget _harness({required MockMarketRepository repo}) {
  return ProviderScope(
    overrides: [marketRepositoryProvider.overrideWithValue(repo)],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      home: const MarketPage(),
    ),
  );
}

void _stubGlobalAndTrendingSuccess(MockMarketRepository repo) {
  when(() => repo.getGlobalMarket()).thenAnswer(
    (_) async => const Right<Failure, GlobalMarket>(_emptyGlobal),
  );
  when(() => repo.getTrendingCoins()).thenAnswer(
    (_) async => const Right<Failure, List<TrendingCoin>>(<TrendingCoin>[]),
  );
}

void main() {
  late MockMarketRepository repo;

  setUp(() {
    repo = MockMarketRepository();
  });

  testWidgets('loading state shows a CircularProgressIndicator', (
    WidgetTester tester,
  ) async {
    final Completer<Either<Failure, List<Coin>>> coins =
        Completer<Either<Failure, List<Coin>>>();
    when(() => repo.getCoins(page: 1)).thenAnswer((_) => coins.future);
    _stubGlobalAndTrendingSuccess(repo);

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    expect(find.byType(CoinListItem), findsNothing);

    // Resolve the pending future so the test tears down cleanly.
    coins.complete(const Right<Failure, List<Coin>>(<Coin>[]));
    await tester.pumpAndSettle();
  });

  testWidgets('data state renders coin rows with name and price', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoins(page: 1)).thenAnswer(
      (_) async => const Right<Failure, List<Coin>>(<Coin>[_btc, _eth]),
    );
    _stubGlobalAndTrendingSuccess(repo);

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pumpAndSettle();

    expect(find.byType(CoinListItem), findsNWidgets(2));
    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('Ethereum'), findsOneWidget);
    expect(find.textContaining(r'$76,764.00'), findsOneWidget);
    expect(find.textContaining('-0.52%'), findsOneWidget);
  });

  testWidgets('empty state shows the no-results message', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoins(page: 1)).thenAnswer(
      (_) async => const Right<Failure, List<Coin>>(<Coin>[]),
    );
    _stubGlobalAndTrendingSuccess(repo);

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pumpAndSettle();

    expect(find.byType(CoinListItem), findsNothing);
    expect(find.textContaining('No results'), findsOneWidget);
  });

  testWidgets('error state shows the error view with Retry', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoins(page: 1)).thenAnswer(
      (_) async =>
          const Left<Failure, List<Coin>>(ServerFailure('HTTP 429')),
    );
    _stubGlobalAndTrendingSuccess(repo);

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pumpAndSettle();

    expect(find.byType(CoinListItem), findsNothing);
    expect(find.textContaining('Failed to load'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('typing in search bar filters the visible coin list', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoins(page: 1)).thenAnswer(
      (_) async => const Right<Failure, List<Coin>>(<Coin>[_btc, _eth]),
    );
    _stubGlobalAndTrendingSuccess(repo);

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pumpAndSettle();

    expect(find.byType(CoinListItem), findsNWidgets(2));

    await tester.enterText(find.byType(TextField), 'eth');
    await tester.pumpAndSettle();

    expect(find.byType(CoinListItem), findsOneWidget);
    expect(find.text('Ethereum'), findsOneWidget);
    expect(find.text('Bitcoin'), findsNothing);
  });
}
