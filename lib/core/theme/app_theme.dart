import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.positive,
    required this.positiveSoft,
    required this.negative,
    required this.negativeSoft,
    required this.favoriteActive,
    required this.favoriteInactive,
    required this.mutedLabel,
    required this.tileBorder,
    required this.tileBackground,
  });

  final Color positive;
  final Color positiveSoft;
  final Color negative;
  final Color negativeSoft;
  final Color favoriteActive;
  final Color favoriteInactive;
  final Color mutedLabel;
  final Color tileBorder;
  final Color tileBackground;

  static const AppSemanticColors light = AppSemanticColors(
    positive: AppColors.positive,
    positiveSoft: AppColors.positiveSoft,
    negative: AppColors.negative,
    negativeSoft: AppColors.negativeSoft,
    favoriteActive: AppColors.favoriteActive,
    favoriteInactive: AppColors.favoriteInactiveLight,
    mutedLabel: AppColors.lightOnSurfaceMuted,
    tileBorder: AppColors.lightBorder,
    tileBackground: AppColors.lightSurfaceAlt,
  );

  static const AppSemanticColors dark = AppSemanticColors(
    positive: AppColors.positive,
    positiveSoft: AppColors.positiveSoft,
    negative: AppColors.negative,
    negativeSoft: AppColors.negativeSoft,
    favoriteActive: AppColors.favoriteActive,
    favoriteInactive: AppColors.favoriteInactiveDark,
    mutedLabel: AppColors.darkOnSurfaceMuted,
    tileBorder: AppColors.darkBorder,
    tileBackground: AppColors.darkSurfaceAlt,
  );

  @override
  AppSemanticColors copyWith({
    Color? positive,
    Color? positiveSoft,
    Color? negative,
    Color? negativeSoft,
    Color? favoriteActive,
    Color? favoriteInactive,
    Color? mutedLabel,
    Color? tileBorder,
    Color? tileBackground,
  }) {
    return AppSemanticColors(
      positive: positive ?? this.positive,
      positiveSoft: positiveSoft ?? this.positiveSoft,
      negative: negative ?? this.negative,
      negativeSoft: negativeSoft ?? this.negativeSoft,
      favoriteActive: favoriteActive ?? this.favoriteActive,
      favoriteInactive: favoriteInactive ?? this.favoriteInactive,
      mutedLabel: mutedLabel ?? this.mutedLabel,
      tileBorder: tileBorder ?? this.tileBorder,
      tileBackground: tileBackground ?? this.tileBackground,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) {
      return this;
    }
    return AppSemanticColors(
      positive: Color.lerp(positive, other.positive, t) ?? positive,
      positiveSoft:
          Color.lerp(positiveSoft, other.positiveSoft, t) ?? positiveSoft,
      negative: Color.lerp(negative, other.negative, t) ?? negative,
      negativeSoft:
          Color.lerp(negativeSoft, other.negativeSoft, t) ?? negativeSoft,
      favoriteActive:
          Color.lerp(favoriteActive, other.favoriteActive, t) ?? favoriteActive,
      favoriteInactive:
          Color.lerp(favoriteInactive, other.favoriteInactive, t) ??
          favoriteInactive,
      mutedLabel: Color.lerp(mutedLabel, other.mutedLabel, t) ?? mutedLabel,
      tileBorder: Color.lerp(tileBorder, other.tileBorder, t) ?? tileBorder,
      tileBackground:
          Color.lerp(tileBackground, other.tileBackground, t) ?? tileBackground,
    );
  }
}

extension AppSemanticColorsX on BuildContext {
  AppSemanticColors get semantic =>
      Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}

class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(
    brightness: Brightness.light,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
    onSurfaceMuted: AppColors.lightOnSurfaceMuted,
    border: AppColors.lightBorder,
    semantic: AppSemanticColors.light,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    onSurfaceMuted: AppColors.darkOnSurfaceMuted,
    border: AppColors.darkBorder,
    semantic: AppSemanticColors.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color onSurface,
    required Color onSurfaceMuted,
    required Color border,
    required AppSemanticColors semantic,
  }) {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.seed,
          brightness: brightness,
        ).copyWith(
          surface: background,
          onSurface: onSurface,
          surfaceContainerHighest: surface,
          outline: border,
          outlineVariant: border,
        );

    final TextTheme baseText = brightness == Brightness.light
        ? Typography.material2021().black
        : Typography.material2021().white;

    const List<String> myanmarFallback = <String>['NotoSansMyanmar'];

    final TextTheme textTheme = baseText
        .copyWith(
          displayLarge: AppTextStyles.pageTitle,
          headlineMedium: AppTextStyles.priceLarge,
          titleMedium: AppTextStyles.coinName,
          bodyMedium: AppTextStyles.bodyDescription,
          labelSmall: AppTextStyles.sectionLabel,
        )
        .apply(
          bodyColor: onSurface,
          displayColor: onSurface,
          fontFamilyFallback: myanmarFallback,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      textTheme: textTheme,
      iconTheme: IconThemeData(color: onSurfaceMuted),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.coinName.copyWith(color: onSurface),
        iconTheme: IconThemeData(color: onSurface),
      ),
      dividerTheme: DividerThemeData(
        color: border,
        space: 1,
        thickness: 1,
      ),
      extensions: <ThemeExtension<dynamic>>[semantic],
    );
  }
}
