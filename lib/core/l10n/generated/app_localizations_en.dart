// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Crypto Tracker';

  @override
  String get markets => 'Markets';

  @override
  String get searchCoins => 'Search coins';

  @override
  String get trending => 'Trending';

  @override
  String get favorites => 'Favorites';

  @override
  String get marketCap => 'Market Cap';

  @override
  String get volume24h => 'Volume 24h';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get loadError => 'Failed to load';

  @override
  String get noResults => 'No results';

  @override
  String get liveLabel => 'LIVE';

  @override
  String get source => 'SOURCE';

  @override
  String get top20Day => 'TOP 20 · 24H';

  @override
  String get volumeShort => 'VOL 24H';

  @override
  String get trending24h => 'TRENDING · 24H';

  @override
  String trendingCoinsCount(int count) {
    return '$count COINS';
  }

  @override
  String get assetHeader => '# ASSET';

  @override
  String get priceHeader => 'PRICE · 24H';

  @override
  String get retry => 'Retry';

  @override
  String get favorite => 'Favorite';

  @override
  String get unfavorite => 'Unfavorite';

  @override
  String get back => 'Back';

  @override
  String favoriteUpdateFailed(String error) {
    return 'Could not update favorite: $error';
  }

  @override
  String refreshFailed(String error) {
    return 'Refresh failed: $error';
  }

  @override
  String get hours24Short => '24h';

  @override
  String rankNumber(int rank) {
    return 'RANK #$rank';
  }

  @override
  String get marketStats => 'MARKET STATS';

  @override
  String get marketCapUpper => 'MARKET CAP';

  @override
  String get volume24hUpper => 'VOLUME 24H';

  @override
  String get allTimeHigh => 'ALL-TIME HIGH';

  @override
  String get allTimeLow => 'ALL-TIME LOW';

  @override
  String get circulatingSupplyLabel => 'CIRCULATING SUPPLY';

  @override
  String get maxSupplyLabel => 'MAX SUPPLY';

  @override
  String get uncappedSupply => '∞ uncapped';

  @override
  String aboutCoin(String name) {
    return 'ABOUT $name';
  }

  @override
  String get sourceCoingecko => 'SOURCE  ·  COINGECKO';

  @override
  String get liveCoingecko => 'LIVE  ·  COINGECKO';

  @override
  String get cachedTag => 'CACHED';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System default';

  @override
  String noResultsForQuery(String query) {
    return 'No results · \"$query\"';
  }
}
