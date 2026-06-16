import 'package:intl/intl.dart';

class Formatters {
  const Formatters._();

  static String price(double value, {String locale = 'en_US'}) {
    final NumberFormat fmt = NumberFormat.currency(
      locale: locale,
      symbol: r'$',
      decimalDigits: _decimalsForPrice(value),
    );
    return fmt.format(value);
  }

  static String compactCurrency(double value, {String locale = 'en_US'}) {
    return NumberFormat.compactCurrency(
      locale: locale,
      symbol: r'$',
      decimalDigits: 2,
    ).format(value);
  }

  static String percent(double value) {
    final String sign = value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(2)}%';
  }

  static String compactNumber(double value, {String locale = 'en_US'}) {
    return NumberFormat.compact(locale: locale).format(value);
  }

  static String supply(double value, String symbol, {String locale = 'en_US'}) {
    return '${compactNumber(value, locale: locale)} ${symbol.toUpperCase()}';
  }

  static String marketCapSubtitle(
    double marketCap, {
    String locale = 'en_US',
  }) {
    return compactCurrency(marketCap, locale: locale);
  }

  static int _decimalsForPrice(double value) {
    final double abs = value.abs();
    if (abs == 0) {
      return 2;
    }
    if (abs >= 1) {
      return 2;
    }
    if (abs >= 0.01) {
      return 4;
    }
    if (abs >= 0.0001) {
      return 6;
    }
    return 8;
  }
}
