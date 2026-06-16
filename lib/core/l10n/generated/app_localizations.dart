import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// Application title shown in launcher and app bar.
  ///
  /// In en, this message translates to:
  /// **'Crypto Tracker'**
  String get appTitle;

  /// No description provided for @markets.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get markets;

  /// No description provided for @searchCoins.
  ///
  /// In en, this message translates to:
  /// **'Search coins'**
  String get searchCoins;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @marketCap.
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get marketCap;

  /// No description provided for @volume24h.
  ///
  /// In en, this message translates to:
  /// **'Volume 24h'**
  String get volume24h;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get loadError;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get noResults;

  /// No description provided for @liveLabel.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get liveLabel;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'SOURCE'**
  String get source;

  /// No description provided for @top20Day.
  ///
  /// In en, this message translates to:
  /// **'TOP 20 · 24H'**
  String get top20Day;

  /// No description provided for @volumeShort.
  ///
  /// In en, this message translates to:
  /// **'VOL 24H'**
  String get volumeShort;

  /// No description provided for @trending24h.
  ///
  /// In en, this message translates to:
  /// **'TRENDING · 24H'**
  String get trending24h;

  /// No description provided for @trendingCoinsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} COINS'**
  String trendingCoinsCount(int count);

  /// No description provided for @assetHeader.
  ///
  /// In en, this message translates to:
  /// **'# ASSET'**
  String get assetHeader;

  /// No description provided for @priceHeader.
  ///
  /// In en, this message translates to:
  /// **'PRICE · 24H'**
  String get priceHeader;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @unfavorite.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get unfavorite;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @favoriteUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update favorite: {error}'**
  String favoriteUpdateFailed(String error);

  /// No description provided for @refreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Refresh failed: {error}'**
  String refreshFailed(String error);

  /// No description provided for @hours24Short.
  ///
  /// In en, this message translates to:
  /// **'24h'**
  String get hours24Short;

  /// No description provided for @rankNumber.
  ///
  /// In en, this message translates to:
  /// **'RANK #{rank}'**
  String rankNumber(int rank);

  /// No description provided for @marketStats.
  ///
  /// In en, this message translates to:
  /// **'MARKET STATS'**
  String get marketStats;

  /// No description provided for @marketCapUpper.
  ///
  /// In en, this message translates to:
  /// **'MARKET CAP'**
  String get marketCapUpper;

  /// No description provided for @volume24hUpper.
  ///
  /// In en, this message translates to:
  /// **'VOLUME 24H'**
  String get volume24hUpper;

  /// No description provided for @allTimeHigh.
  ///
  /// In en, this message translates to:
  /// **'ALL-TIME HIGH'**
  String get allTimeHigh;

  /// No description provided for @allTimeLow.
  ///
  /// In en, this message translates to:
  /// **'ALL-TIME LOW'**
  String get allTimeLow;

  /// No description provided for @circulatingSupplyLabel.
  ///
  /// In en, this message translates to:
  /// **'CIRCULATING SUPPLY'**
  String get circulatingSupplyLabel;

  /// No description provided for @maxSupplyLabel.
  ///
  /// In en, this message translates to:
  /// **'MAX SUPPLY'**
  String get maxSupplyLabel;

  /// No description provided for @uncappedSupply.
  ///
  /// In en, this message translates to:
  /// **'∞ uncapped'**
  String get uncappedSupply;

  /// No description provided for @aboutCoin.
  ///
  /// In en, this message translates to:
  /// **'ABOUT {name}'**
  String aboutCoin(String name);

  /// No description provided for @sourceCoingecko.
  ///
  /// In en, this message translates to:
  /// **'SOURCE  ·  COINGECKO'**
  String get sourceCoingecko;

  /// No description provided for @liveCoingecko.
  ///
  /// In en, this message translates to:
  /// **'LIVE  ·  COINGECKO'**
  String get liveCoingecko;

  /// No description provided for @cachedTag.
  ///
  /// In en, this message translates to:
  /// **'CACHED'**
  String get cachedTag;

  /// No description provided for @noResultsForQuery.
  ///
  /// In en, this message translates to:
  /// **'No results · \"{query}\"'**
  String noResultsForQuery(String query);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
