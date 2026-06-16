import 'package:crypto_tracker/core/error/exceptions.dart';
import 'package:crypto_tracker/core/error/failure.dart';
import 'package:crypto_tracker/core/network/network_info.dart';
import 'package:crypto_tracker/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:crypto_tracker/features/market/data/datasources/market_local_datasource.dart';
import 'package:crypto_tracker/features/market/data/datasources/market_remote_datasource.dart';
import 'package:crypto_tracker/features/market/data/models/coin_model.dart';
import 'package:crypto_tracker/features/market/data/models/global_market_model.dart';
import 'package:crypto_tracker/features/market/data/models/trending_coin_model.dart';
import 'package:crypto_tracker/features/market/data/repositories/market_repository_impl.dart';
import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements MarketRemoteDataSource {}

class _MockLocal extends Mock implements MarketLocalDataSource {}

class _MockFavorites extends Mock implements FavoritesRepository {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

const CoinModel _tBtcModel = CoinModel(
  id: 'bitcoin',
  symbol: 'btc',
  name: 'Bitcoin',
  image: 'https://example.com/btc.png',
  currentPrice: 76764.0,
  marketCap: 1540000000000,
  marketCapRank: 1,
  priceChangePercentage24h: -0.52,
  totalVolume: 35000000000,
);

const CoinModel _tEthModel = CoinModel(
  id: 'ethereum',
  symbol: 'eth',
  name: 'Ethereum',
  image: 'https://example.com/eth.png',
  currentPrice: 2095.85,
  marketCap: 253150000000,
  marketCapRank: 2,
  priceChangePercentage24h: -0.13,
  totalVolume: 9780000000,
);

const List<CoinModel> _tCoinModels = <CoinModel>[_tBtcModel, _tEthModel];

const GlobalMarketModel _tGlobalModel = GlobalMarketModel(
  totalMarketCap: <String, double>{'usd': 2440000000000},
  totalVolume: <String, double>{'usd': 93220000000},
  marketCapChangePercentage24hUsd: -0.42,
);

const TrendingCoinModel _tTrendingModel = TrendingCoinModel(
  id: 'bonk',
  name: 'Bonk',
  symbol: 'BONK',
  thumb: 'https://example.com/bonk.png',
  marketCapRank: 102,
  data: TrendingCoinDataModel(
    price: 0.00000601,
    priceChangePercentage24h: <String, double>{'usd': -1.36},
  ),
);

void main() {
  late _MockRemote remote;
  late _MockLocal local;
  late _MockFavorites favorites;
  late _MockNetworkInfo network;
  late MarketRepositoryImpl repo;

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    favorites = _MockFavorites();
    network = _MockNetworkInfo();
    repo = MarketRepositoryImpl(
      remote: remote,
      local: local,
      favorites: favorites,
      networkInfo: network,
    );
    registerFallbackValue(<CoinModel>[]);
    registerFallbackValue(_tGlobalModel);
    registerFallbackValue(<TrendingCoinModel>[]);
  });

  void whenOnline({required bool online}) =>
      when(() => network.isConnected).thenAnswer((_) async => online);

  group('getCoins(page: 1)', () {
    test('online success → Right with favorites merged and caches page 1',
        () async {
      whenOnline(online: true);
      when(() => remote.getCoins(page: 1))
          .thenAnswer((_) async => _tCoinModels);
      when(() => local.cacheCoinsPage1(any())).thenAnswer((_) async {});
      when(favorites.getFavoriteIds)
          .thenAnswer((_) async => <String>{'ethereum'});

      final Either<Failure, List<Coin>> result =
          await repo.getCoins(page: 1);

      expect(result.isRight(), isTrue);
      final List<Coin> coins =
          result.getRight().getOrElse(() => <Coin>[]);
      expect(coins, hasLength(2));
      expect(coins[0].id, 'bitcoin');
      expect(coins[0].isFavorite, isFalse);
      expect(coins[1].id, 'ethereum');
      expect(coins[1].isFavorite, isTrue);
      verify(() => local.cacheCoinsPage1(_tCoinModels)).called(1);
    });

    test('online failure → Left(ServerFailure), no caching', () async {
      whenOnline(online: true);
      when(() => remote.getCoins(page: 1))
          .thenThrow(const ServerException('boom'));

      final Either<Failure, List<Coin>> result =
          await repo.getCoins(page: 1);

      expect(result, const Left<Failure, List<Coin>>(ServerFailure('boom')));
      verifyNever(() => local.cacheCoinsPage1(any()));
    });

    test('offline + cache hit → Right(cached) with favorites merged',
        () async {
      whenOnline(online: false);
      when(local.getCachedCoinsPage1)
          .thenAnswer((_) async => _tCoinModels);
      when(favorites.getFavoriteIds)
          .thenAnswer((_) async => <String>{'bitcoin'});

      final Either<Failure, List<Coin>> result =
          await repo.getCoins(page: 1);

      final List<Coin> coins =
          result.getRight().getOrElse(() => <Coin>[]);
      expect(coins, hasLength(2));
      expect(coins[0].isFavorite, isTrue);
      expect(coins[1].isFavorite, isFalse);
      verifyNever(() => remote.getCoins(page: any(named: 'page')));
    });

    test('offline + no cache → Left(NetworkFailure)', () async {
      whenOnline(online: false);
      when(local.getCachedCoinsPage1)
          .thenThrow(const CacheException());

      final Either<Failure, List<Coin>> result =
          await repo.getCoins(page: 1);

      expect(result, const Left<Failure, List<Coin>>(NetworkFailure()));
    });
  });

  group('getCoins(page: 2)', () {
    test('online success → Right but does not cache higher pages', () async {
      whenOnline(online: true);
      when(() => remote.getCoins(page: 2))
          .thenAnswer((_) async => _tCoinModels);
      when(favorites.getFavoriteIds)
          .thenAnswer((_) async => <String>{});

      await repo.getCoins(page: 2);

      verifyNever(() => local.cacheCoinsPage1(any()));
    });

    test('offline → Left(NetworkFailure) without touching the cache',
        () async {
      whenOnline(online: false);

      final Either<Failure, List<Coin>> result =
          await repo.getCoins(page: 2);

      expect(result, const Left<Failure, List<Coin>>(NetworkFailure()));
      verifyNever(local.getCachedCoinsPage1);
    });
  });

  group('getGlobalMarket', () {
    test('online success → Right(entity) and caches', () async {
      whenOnline(online: true);
      when(remote.getGlobalMarket).thenAnswer((_) async => _tGlobalModel);
      when(() => local.cacheGlobalMarket(any())).thenAnswer((_) async {});

      final Either<Failure, GlobalMarket> result =
          await repo.getGlobalMarket();

      expect(
        result.getRight().getOrElse(
              () => const GlobalMarket(
                totalMarketCapUsd: 0,
                totalVolumeUsd: 0,
                marketCapChangePercentage24hUsd: 0,
              ),
            ),
        const GlobalMarket(
          totalMarketCapUsd: 2440000000000,
          totalVolumeUsd: 93220000000,
          marketCapChangePercentage24hUsd: -0.42,
        ),
      );
      verify(() => local.cacheGlobalMarket(_tGlobalModel)).called(1);
    });

    test('online failure → Left(ServerFailure)', () async {
      whenOnline(online: true);
      when(remote.getGlobalMarket)
          .thenThrow(const ServerException('502'));

      final Either<Failure, GlobalMarket> result =
          await repo.getGlobalMarket();

      expect(result, const Left<Failure, GlobalMarket>(ServerFailure('502')));
    });

    test('offline + cache hit → Right(cached)', () async {
      whenOnline(online: false);
      when(local.getCachedGlobalMarket)
          .thenAnswer((_) async => _tGlobalModel);

      final Either<Failure, GlobalMarket> result =
          await repo.getGlobalMarket();

      expect(result.isRight(), isTrue);
      verifyNever(remote.getGlobalMarket);
    });

    test('offline + no cache → Left(NetworkFailure)', () async {
      whenOnline(online: false);
      when(local.getCachedGlobalMarket).thenThrow(const CacheException());

      final Either<Failure, GlobalMarket> result =
          await repo.getGlobalMarket();

      expect(result, const Left<Failure, GlobalMarket>(NetworkFailure()));
    });
  });

  group('getTrendingCoins', () {
    test('online success → Right(entities) and caches', () async {
      whenOnline(online: true);
      when(remote.getTrendingCoins)
          .thenAnswer((_) async => <TrendingCoinModel>[_tTrendingModel]);
      when(() => local.cacheTrendingCoins(any())).thenAnswer((_) async {});

      final Either<Failure, List<TrendingCoin>> result =
          await repo.getTrendingCoins();

      final List<TrendingCoin> entities =
          result.getRight().getOrElse(() => <TrendingCoin>[]);
      expect(entities, hasLength(1));
      expect(entities.first.id, 'bonk');
      verify(
        () => local.cacheTrendingCoins(<TrendingCoinModel>[_tTrendingModel]),
      ).called(1);
    });

    test('online failure → Left(ServerFailure)', () async {
      whenOnline(online: true);
      when(remote.getTrendingCoins)
          .thenThrow(const ServerException('rate limit'));

      final Either<Failure, List<TrendingCoin>> result =
          await repo.getTrendingCoins();

      expect(
        result,
        const Left<Failure, List<TrendingCoin>>(ServerFailure('rate limit')),
      );
    });

    test('offline + cache hit → Right(cached)', () async {
      whenOnline(online: false);
      when(local.getCachedTrendingCoins)
          .thenAnswer((_) async => <TrendingCoinModel>[_tTrendingModel]);

      final Either<Failure, List<TrendingCoin>> result =
          await repo.getTrendingCoins();

      expect(result.isRight(), isTrue);
      verifyNever(remote.getTrendingCoins);
    });

    test('offline + no cache → Left(NetworkFailure)', () async {
      whenOnline(online: false);
      when(local.getCachedTrendingCoins).thenThrow(const CacheException());

      final Either<Failure, List<TrendingCoin>> result =
          await repo.getTrendingCoins();

      expect(
        result,
        const Left<Failure, List<TrendingCoin>>(NetworkFailure()),
      );
    });
  });
}
