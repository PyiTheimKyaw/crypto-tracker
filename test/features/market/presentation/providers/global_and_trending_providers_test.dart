import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/presentation/providers/global_market_provider.dart';
import 'package:crypto_tracker/features/market/presentation/providers/market_providers.dart';
import 'package:crypto_tracker/features/market/presentation/providers/trending_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/market_mocks.dart';

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

  group('globalMarketProvider', () {
    test('AsyncData on success', () async {
      when(() => repo.getGlobalMarket()).thenAnswer(
        (_) async => const Right<Failure, GlobalMarket>(tGlobalMarket),
      );

      final ProviderContainer container = _makeContainer(repo);
      final GlobalMarket data =
          await container.read(globalMarketProvider.future);

      expect(data, tGlobalMarket);
      expect(container.read(globalMarketProvider).hasValue, isTrue);
    });

    test('AsyncError when repository returns Left', () async {
      when(() => repo.getGlobalMarket()).thenAnswer(
        (_) async =>
            const Left<Failure, GlobalMarket>(NetworkFailure()),
      );

      final ProviderContainer container = _makeContainer(repo);
      container.listen<AsyncValue<GlobalMarket>>(
        globalMarketProvider,
        (_, __) {},
      );
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      final AsyncValue<GlobalMarket> snap =
          container.read(globalMarketProvider);
      expect(snap.hasError, isTrue);
      expect(snap.error, isA<NetworkFailure>());
    });
  });

  group('trendingProvider', () {
    test('AsyncData on success', () async {
      when(() => repo.getTrendingCoins()).thenAnswer(
        (_) async =>
            const Right<Failure, List<TrendingCoin>>(tTrendingList),
      );

      final ProviderContainer container = _makeContainer(repo);
      final List<TrendingCoin> data =
          await container.read(trendingProvider.future);

      expect(data, tTrendingList);
    });

    test('AsyncError when repository returns Left', () async {
      when(() => repo.getTrendingCoins()).thenAnswer(
        (_) async => const Left<Failure, List<TrendingCoin>>(
          ServerFailure('rate limit'),
        ),
      );

      final ProviderContainer container = _makeContainer(repo);
      container.listen<AsyncValue<List<TrendingCoin>>>(
        trendingProvider,
        (_, __) {},
      );
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      final AsyncValue<List<TrendingCoin>> snap =
          container.read(trendingProvider);
      expect(snap.hasError, isTrue);
      expect(snap.error, isA<ServerFailure>());
    });
  });
}
