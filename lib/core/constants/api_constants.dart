class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://api.coingecko.com/api/v3/';

  static const String coinsMarkets = 'coins/markets';
  static const String global = 'global';
  static const String trending = 'search/trending';
  static String coinDetail(String id) => 'coins/$id';

  static const String vsCurrency = 'usd';
  static const int perPage = 20;

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 15);
}
