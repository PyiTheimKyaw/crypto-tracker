import 'package:crypto_tracker/core/constants/api_constants.dart';
import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:crypto_tracker/features/market/presentation/providers/coin_list_notifier.dart';
import 'package:crypto_tracker/features/market/presentation/providers/market_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/market_mocks.dart';

List<Coin> _coins(int startRank, int count, {String prefix = 'c'}) {
  return List<Coin>.generate(
    count,
    (int i) => Coin(
      id: '$prefix-${startRank + i}',
      symbol: '${prefix.toUpperCase()}${startRank + i}',
      name: 'Coin ${startRank + i}',
      image: '',
      currentPrice: 1.0,
      marketCap: 1.0,
      marketCapRank: startRank + i,
      priceChangePercentage24h: 0,
      totalVolume: 0,
    ),
  );
}

ProviderContainer _makeContainer(MockMarketRepository repo) {
  final ProviderContainer container = ProviderContainer(
    overrides: [marketRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  late MockMarketRepository repo;

  setUp(() {
    repo = MockMarketRepository();
  });

  group('CoinListNotifier build', () {
    test('loading → data when first page succeeds', () async {
      final List<Coin> page1 = _coins(1, ApiConstants.perPage);
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => Right<Failure, List<Coin>>(page1));

      final ProviderContainer container = _makeContainer(repo);

      expect(container.read(coinListProvider).isLoading, isTrue);

      final CoinListState state =
          await container.read(coinListProvider.future);

      expect(state.coins, page1);
      expect(state.page, 1);
      expect(state.hasMore, isTrue);
      expect(state.query, '');
      expect(container.read(coinListProvider).hasValue, isTrue);
    });

    test('loading → error when first page fails', () async {
      when(() => repo.getCoins(page: 1)).thenAnswer(
        (_) async =>
            const Left<Failure, List<Coin>>(ServerFailure('boom')),
      );

      final ProviderContainer container = _makeContainer(repo);
      container.listen<AsyncValue<CoinListState>>(
        coinListProvider,
        (_, __) {},
      );
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      final AsyncValue<CoinListState> snap = container.read(coinListProvider);
      expect(snap.hasError, isTrue);
      expect(snap.error, isA<ServerFailure>());
    });

    test('hasMore=false when first page returns fewer than perPage', () async {
      final List<Coin> shortPage = _coins(1, 5);
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => Right<Failure, List<Coin>>(shortPage));

      final ProviderContainer container = _makeContainer(repo);
      final CoinListState state =
          await container.read(coinListProvider.future);

      expect(state.hasMore, isFalse);
    });
  });

  group('CoinListNotifier loadNextPage', () {
    test('appends page 2 coins and increments page', () async {
      final List<Coin> page1 = _coins(1, ApiConstants.perPage);
      final List<Coin> page2 = _coins(21, ApiConstants.perPage);
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => Right<Failure, List<Coin>>(page1));
      when(() => repo.getCoins(page: 2))
          .thenAnswer((_) async => Right<Failure, List<Coin>>(page2));

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);

      await container.read(coinListProvider.notifier).loadNextPage();

      final CoinListState state =
          container.read(coinListProvider).requireValue;
      expect(state.coins, <Coin>[...page1, ...page2]);
      expect(state.page, 2);
      expect(state.hasMore, isTrue);
    });

    test('marks hasMore=false when next page is short', () async {
      when(() => repo.getCoins(page: 1)).thenAnswer(
        (_) async =>
            Right<Failure, List<Coin>>(_coins(1, ApiConstants.perPage)),
      );
      when(() => repo.getCoins(page: 2)).thenAnswer(
        (_) async => Right<Failure, List<Coin>>(_coins(21, 3)),
      );

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);
      await container.read(coinListProvider.notifier).loadNextPage();

      final CoinListState state =
          container.read(coinListProvider).requireValue;
      expect(state.coins, hasLength(ApiConstants.perPage + 3));
      expect(state.hasMore, isFalse);
    });

    test('no-op when hasMore=false', () async {
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => Right<Failure, List<Coin>>(_coins(1, 3)));

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);
      reset(repo);

      await container.read(coinListProvider.notifier).loadNextPage();

      verifyNever(() => repo.getCoins(page: any(named: 'page')));
    });

    test('transitions to AsyncError when next page fails', () async {
      when(() => repo.getCoins(page: 1)).thenAnswer(
        (_) async =>
            Right<Failure, List<Coin>>(_coins(1, ApiConstants.perPage)),
      );
      when(() => repo.getCoins(page: 2)).thenAnswer(
        (_) async =>
            const Left<Failure, List<Coin>>(NetworkFailure()),
      );

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);
      await container.read(coinListProvider.notifier).loadNextPage();

      final AsyncValue<CoinListState> snap = container.read(coinListProvider);
      expect(snap.hasError, isTrue);
      expect(snap.error, isA<NetworkFailure>());
    });
  });

  group('CoinListNotifier refresh', () {
    test('resets to page 1 and reloads', () async {
      final List<Coin> firstLoad = _coins(1, ApiConstants.perPage);
      final List<Coin> nextLoad = _coins(100, 4);
      int callCount = 0;
      when(() => repo.getCoins(page: 1)).thenAnswer((_) async {
        callCount += 1;
        return Right<Failure, List<Coin>>(
          callCount == 1 ? firstLoad : nextLoad,
        );
      });

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);

      await container.read(coinListProvider.notifier).refresh();
      final CoinListState state =
          container.read(coinListProvider).requireValue;

      expect(state.page, 1);
      expect(state.coins, nextLoad);
      expect(state.hasMore, isFalse);
      verify(() => repo.getCoins(page: 1)).called(2);
    });
  });

  group('CoinListNotifier search', () {
    test('filters by name (case-insensitive)', () async {
      const Coin btc = Coin(
        id: 'bitcoin',
        symbol: 'btc',
        name: 'Bitcoin',
        image: '',
        currentPrice: 1,
        marketCap: 1,
        marketCapRank: 1,
        priceChangePercentage24h: 0,
        totalVolume: 0,
      );
      const Coin eth = Coin(
        id: 'ethereum',
        symbol: 'eth',
        name: 'Ethereum',
        image: '',
        currentPrice: 1,
        marketCap: 1,
        marketCapRank: 2,
        priceChangePercentage24h: 0,
        totalVolume: 0,
      );
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => const Right<Failure, List<Coin>>(<Coin>[btc, eth]));

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);

      container.read(coinListProvider.notifier).search('eth');
      final CoinListState state =
          container.read(coinListProvider).requireValue;

      expect(state.query, 'eth');
      expect(state.filteredCoins, <Coin>[eth]);
      expect(state.coins, <Coin>[btc, eth]);
    });

    test('filters by symbol (case-insensitive)', () async {
      const Coin btc = Coin(
        id: 'bitcoin',
        symbol: 'btc',
        name: 'Bitcoin',
        image: '',
        currentPrice: 1,
        marketCap: 1,
        marketCapRank: 1,
        priceChangePercentage24h: 0,
        totalVolume: 0,
      );
      const Coin eth = Coin(
        id: 'ethereum',
        symbol: 'eth',
        name: 'Ethereum',
        image: '',
        currentPrice: 1,
        marketCap: 1,
        marketCapRank: 2,
        priceChangePercentage24h: 0,
        totalVolume: 0,
      );
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => const Right<Failure, List<Coin>>(<Coin>[btc, eth]));

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);

      container.read(coinListProvider.notifier).search('BTC');
      final CoinListState state =
          container.read(coinListProvider).requireValue;

      expect(state.filteredCoins, <Coin>[btc]);
    });

    test('empty query returns all loaded coins', () async {
      final List<Coin> page1 = _coins(1, 4);
      when(() => repo.getCoins(page: 1))
          .thenAnswer((_) async => Right<Failure, List<Coin>>(page1));

      final ProviderContainer container = _makeContainer(repo);
      await container.read(coinListProvider.future);

      container.read(coinListProvider.notifier).search('zzz');
      container.read(coinListProvider.notifier).search('');
      final CoinListState state =
          container.read(coinListProvider).requireValue;

      expect(state.filteredCoins, page1);
    });
  });
}
