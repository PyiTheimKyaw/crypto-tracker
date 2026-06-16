// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'Crypto ခြေရာခံ';

  @override
  String get markets => 'ဈေးကွက်များ';

  @override
  String get searchCoins => 'ကွိင်များ ရှာဖွေပါ';

  @override
  String get trending => 'ခေတ်စားနေသော';

  @override
  String get favorites => 'ကြိုက်နှစ်သက်ရာများ';

  @override
  String get marketCap => 'ဈေးကွက်တန်ဖိုး';

  @override
  String get volume24h => 'ပမာဏ ၂၄ နာရီ';

  @override
  String get noInternet => 'အင်တာနက် ချိတ်ဆက်မှု မရှိပါ';

  @override
  String get loadError => 'ဒေတာ ဖွင့်၍ မရပါ';

  @override
  String get noResults => 'ရလဒ် မရှိပါ';

  @override
  String get liveLabel => 'တိုက်ရိုက်';

  @override
  String get source => 'ရင်းမြစ်';

  @override
  String get top20Day => 'ထိပ်တန်း ၂၀ · ၂၄ နာရီ';

  @override
  String get volumeShort => 'ပမာဏ ၂၄ နာရီ';

  @override
  String get trending24h => 'ခေတ်စားနေသော · ၂၄ နာရီ';

  @override
  String trendingCoinsCount(int count) {
    return 'ကွိုင် $count ခု';
  }

  @override
  String get assetHeader => '# ပိုင်ဆိုင်မှု';

  @override
  String get priceHeader => 'စျေးနှုန်း · ၂၄ နာရီ';

  @override
  String get retry => 'ပြန်စမ်းရန်';

  @override
  String get favorite => 'ကြိုက်ရန်';

  @override
  String get unfavorite => 'ဖယ်ရှားရန်';

  @override
  String get back => 'ပြန်သွားရန်';

  @override
  String favoriteUpdateFailed(String error) {
    return 'ကြိုက်နှစ်သက်ရာ ပြောင်းလဲ၍ မရပါ — $error';
  }

  @override
  String refreshFailed(String error) {
    return 'ပြန်လည် ဖွင့်ရန် မအောင်မြင်ပါ — $error';
  }

  @override
  String get hours24Short => '၂၄ နာရီ';

  @override
  String rankNumber(int rank) {
    return 'အဆင့် #$rank';
  }

  @override
  String get marketStats => 'ဈေးကွက် စာရင်းအင်း';

  @override
  String get marketCapUpper => 'ဈေးကွက်တန်ဖိုး';

  @override
  String get volume24hUpper => 'ပမာဏ ၂၄ နာရီ';

  @override
  String get allTimeHigh => 'အမြင့်ဆုံး စျေးနှုန်း';

  @override
  String get allTimeLow => 'အနိမ့်ဆုံး စျေးနှုန်း';

  @override
  String get circulatingSupplyLabel => 'လည်ပတ်နေသော ပမာဏ';

  @override
  String get maxSupplyLabel => 'အများဆုံး ပမာဏ';

  @override
  String get uncappedSupply => '∞ ကန့်သတ်မထား';

  @override
  String aboutCoin(String name) {
    return '$name အကြောင်း';
  }

  @override
  String get sourceCoingecko => 'ရင်းမြစ်  ·  COINGECKO';

  @override
  String get liveCoingecko => 'တိုက်ရိုက်  ·  COINGECKO';

  @override
  String get cachedTag => 'သိမ်းထား';

  @override
  String get language => 'ဘာသာစကား';

  @override
  String get systemDefault => 'စနစ်အလိုက်';

  @override
  String noResultsForQuery(String query) {
    return 'ရလဒ်မရှိ · \"$query\"';
  }
}
