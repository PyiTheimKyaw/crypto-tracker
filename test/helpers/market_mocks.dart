import 'package:crypto_tracker/features/market/domain/entities/coin.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/domain/repositories/market_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketRepository extends Mock implements MarketRepository {}

const Coin tCoinBitcoin = Coin(
  id: 'bitcoin',
  symbol: 'btc',
  name: 'Bitcoin',
  image: 'https://example.com/btc.png',
  currentPrice: 76764.00,
  marketCap: 1540000000000,
  marketCapRank: 1,
  priceChangePercentage24h: -0.52,
  totalVolume: 35000000000,
);

const Coin tCoinEthereum = Coin(
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

const List<Coin> tCoinsPage1 = <Coin>[tCoinBitcoin, tCoinEthereum];

const GlobalMarket tGlobalMarket = GlobalMarket(
  totalMarketCapUsd: 2440000000000,
  totalVolumeUsd: 93220000000,
  marketCapChangePercentage24hUsd: -0.42,
);

const TrendingCoin tTrendingBonk = TrendingCoin(
  id: 'bonk',
  name: 'Bonk',
  symbol: 'bonk',
  thumb: 'https://example.com/bonk.png',
  marketCapRank: 102,
  priceUsd: 0.00000601,
  priceChangePercentage24hUsd: -1.36,
);

const List<TrendingCoin> tTrendingList = <TrendingCoin>[tTrendingBonk];
