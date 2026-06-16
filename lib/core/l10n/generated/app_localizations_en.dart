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
  String get marketCap => 'Market Cap';

  @override
  String get volume24h => 'Volume 24h';

  @override
  String get trending => 'Trending';

  @override
  String get favorites => 'Favorites';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get loadError => 'Failed to load';

  @override
  String get noResults => 'No results';
}
