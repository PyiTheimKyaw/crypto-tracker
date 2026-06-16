import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core_providers.dart';

class LocaleNotifier extends Notifier<Locale?> {
  static const String _key = 'locale';

  @override
  Locale? build() {
    final String? code = ref.read(settingsBoxProvider).get(_key);
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    final box = ref.read(settingsBoxProvider);
    if (locale == null) {
      await box.delete(_key);
    } else {
      await box.put(_key, locale.languageCode);
    }
    state = locale;
  }
}

final NotifierProvider<LocaleNotifier, Locale?> localeProvider =
    NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);
