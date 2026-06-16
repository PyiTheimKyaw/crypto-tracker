import 'dart:async';

import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/core/l10n/generated/app_localizations.dart';
import 'package:crypto_tracker/core/theme/app_theme.dart';
import 'package:crypto_tracker/features/coin_detail/domain/entities/coin_detail.dart';
import 'package:crypto_tracker/features/coin_detail/domain/repositories/coin_detail_repository.dart';
import 'package:crypto_tracker/features/coin_detail/presentation/pages/coin_detail_page.dart';
import 'package:crypto_tracker/features/coin_detail/presentation/providers/coin_detail_providers.dart';
import 'package:crypto_tracker/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:crypto_tracker/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoinDetailRepo extends Mock implements CoinDetailRepository {}

class _MockFavorites extends Mock implements FavoritesRepository {}

const CoinDetail _tEth = CoinDetail(
  id: 'ethereum',
  symbol: 'eth',
  name: 'Ethereum',
  image: '',
  marketCapRank: 2,
  currentPrice: 2095.85,
  priceChangePercentage24h: -0.13,
  marketCap: 253150000000,
  totalVolume: 9780000000,
  ath: 4878.00,
  athChangePercentage: -57.03,
  atl: 0.43,
  atlChangePercentage: 487306.98,
  circulatingSupply: 120280000,
  totalSupply: 120280000,
  description:
      'Ethereum is a decentralized computing platform that executes smart contracts.',
);

FavoritesRepository _stubFavorites({Set<String> initial = const <String>{}}) {
  final _MockFavorites favs = _MockFavorites();
  when(favs.watchFavorites)
      .thenAnswer((_) => Stream<Set<String>>.value(initial));
  when(favs.getFavoriteIds).thenAnswer((_) async => initial);
  when(() => favs.toggleFavorite(any())).thenAnswer(
    (_) async => const Right<Failure, bool>(true),
  );
  return favs;
}

Widget _harness({
  required CoinDetailRepository repo,
  FavoritesRepository? favorites,
  String id = 'ethereum',
}) {
  return ProviderScope(
    overrides: [
      coinDetailRepositoryProvider.overrideWithValue(repo),
      favoritesRepositoryProvider.overrideWithValue(
        favorites ?? _stubFavorites(),
      ),
    ],
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
      home: CoinDetailPage(id: id),
    ),
  );
}

void main() {
  late _MockCoinDetailRepo repo;

  setUp(() {
    repo = _MockCoinDetailRepo();
  });

  testWidgets('loading state shows a CircularProgressIndicator', (
    WidgetTester tester,
  ) async {
    final Completer<Either<Failure, CoinDetail>> pending =
        Completer<Either<Failure, CoinDetail>>();
    when(() => repo.getCoinDetail('ethereum'))
        .thenAnswer((_) => pending.future);

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    expect(find.textContaining('MARKET STATS'), findsNothing);

    pending.complete(const Right<Failure, CoinDetail>(_tEth));
    await tester.pumpAndSettle();
  });

  testWidgets('data state renders title, price, stats, and about section', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoinDetail('ethereum')).thenAnswer(
      (_) async => const Right<Failure, CoinDetail>(_tEth),
    );

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pumpAndSettle();

    expect(find.text('ETH  ·  RANK #2'), findsOneWidget);
    expect(find.text('ETHEREUM'), findsOneWidget);
    expect(find.textContaining(r'$2,095.85'), findsOneWidget);
    expect(find.textContaining('-0.13%'), findsOneWidget);

    expect(find.text('MARKET STATS'), findsOneWidget);
    expect(find.text('MARKET CAP'), findsOneWidget);
    expect(find.text('VOLUME 24H'), findsOneWidget);
    expect(find.text('ALL-TIME HIGH'), findsOneWidget);
    expect(find.text('ALL-TIME LOW'), findsOneWidget);

    expect(find.text('MAX SUPPLY'), findsOneWidget);
    expect(find.text('∞ uncapped'), findsOneWidget);

    expect(find.text('ABOUT ETHEREUM'), findsOneWidget);
    expect(find.textContaining('decentralized computing'), findsOneWidget);
  });

  testWidgets('error state shows the error view with Retry', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoinDetail('ethereum')).thenAnswer(
      (_) async =>
          const Left<Failure, CoinDetail>(ServerFailure('HTTP 500')),
    );

    await tester.pumpWidget(_harness(repo: repo));
    await tester.pumpAndSettle();

    expect(find.textContaining('Failed to load'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('MARKET STATS'), findsNothing);
  });

  testWidgets('favorite star reflects stream and tap toggles', (
    WidgetTester tester,
  ) async {
    when(() => repo.getCoinDetail('ethereum')).thenAnswer(
      (_) async => const Right<Failure, CoinDetail>(_tEth),
    );

    final _MockFavorites favs = _MockFavorites();
    when(favs.watchFavorites)
        .thenAnswer((_) => Stream<Set<String>>.value(<String>{}));
    when(favs.getFavoriteIds).thenAnswer((_) async => <String>{});
    when(() => favs.toggleFavorite('ethereum')).thenAnswer(
      (_) async => const Right<Failure, bool>(true),
    );

    await tester.pumpWidget(_harness(repo: repo, favorites: favs));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star_border), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNothing);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pump();

    verify(() => favs.toggleFavorite('ethereum')).called(1);
  });
}
