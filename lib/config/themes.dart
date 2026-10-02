// SPDX-FileCopyrightText: 2019-Present Christian Kußowski
// SPDX-FileCopyrightText: 2019-Present Contributors to FluffyChat
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

abstract class FluffyThemes {
  static const double columnWidth = 380.0;

  static const double maxTimelineWidth = columnWidth * 2;

  static const double navRailWidth = 80.0;

  static bool isColumnModeByWidth(double width) =>
      width > columnWidth * 2 + navRailWidth;

  static bool isColumnMode(BuildContext context) =>
      isColumnModeByWidth(MediaQuery.sizeOf(context).width);

  static bool isThreeColumnMode(BuildContext context) =>
      MediaQuery.sizeOf(context).width > FluffyThemes.columnWidth * 3.5;

  static LinearGradient backgroundGradient(BuildContext context, int alpha) {
    final colorScheme = Theme.of(context).colorScheme;
    return LinearGradient(
      begin: Alignment.topCenter,
      colors: [
        colorScheme.primaryContainer.withAlpha(alpha),
        colorScheme.secondaryContainer.withAlpha(alpha),
        colorScheme.tertiaryContainer.withAlpha(alpha),
        colorScheme.primaryContainer.withAlpha(alpha),
      ],
    );
  }

  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Curve animationCurve = Curves.easeInOut;

  static ThemeData buildTheme(
    BuildContext context,
    Brightness brightness, [
    Color? seed,
  ]) {
    final seedColor = seed ?? Color(AppSettings.colorSchemeSeedInt.value);
    var colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: seedColor,
      dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
    );
    if (seedColor == AppConfig.primaryColor) {
      colorScheme = brightness == Brightness.light
          ? colorScheme.copyWith(
              primary: const Color(0xFF334420),
              onPrimary: const Color(0xFFF7F5EE),
              primaryContainer: const Color(0xFFDAE5CB),
              onPrimaryContainer: const Color(0xFF24321A),
              secondary: const Color(0xFF576B40),
              secondaryContainer: const Color(0xFFE9EDD9),
              onSecondaryContainer: const Color(0xFF29371E),
              tertiary: const Color(0xFF806321),
              onTertiary: const Color(0xFFFFF9E6),
              tertiaryContainer: const Color(0xFFF3E6B9),
              onTertiaryContainer: const Color(0xFF4F3C10),
              surface: const Color(0xFFF7F5EE),
              onSurface: const Color(0xFF1B2819),
              onSurfaceVariant: const Color(0xFF56624F),
              surfaceContainerLowest: const Color(0xFFFFFEFA),
              surfaceContainerLow: const Color(0xFFF1F2E8),
              surfaceContainer: const Color(0xFFEAEDDF),
              surfaceContainerHigh: const Color(0xFFE2E7D5),
              surfaceContainerHighest: const Color(0xFFD8DECC),
              outline: const Color(0xFF829171),
              outlineVariant: const Color(0xFFD9DECB),
            )
          : colorScheme.copyWith(
              primary: const Color(0xFFB7CF8C),
              onPrimary: const Color(0xFF253418),
              primaryContainer: const Color(0xFF334420),
              onPrimaryContainer: const Color(0xFFF7F5EE),
              secondary: const Color(0xFFC1CEAE),
              onSecondary: const Color(0xFF28321E),
              secondaryContainer: const Color(0xFF2A3525),
              onSecondaryContainer: const Color(0xFFE2EBD7),
              tertiary: const Color(0xFFD9B96E),
              onTertiary: const Color(0xFF35260B),
              tertiaryContainer: const Color(0xFF493916),
              onTertiaryContainer: const Color(0xFFF1DA9E),
              surface: const Color(0xFF111A12),
              onSurface: const Color(0xFFF7F5EE),
              onSurfaceVariant: const Color(0xFFB7C2AE),
              surfaceContainerLowest: const Color(0xFF0C120D),
              surfaceContainerLow: const Color(0xFF172019),
              surfaceContainer: const Color(0xFF1C271D),
              surfaceContainerHigh: const Color(0xFF253026),
              surfaceContainerHighest: const Color(0xFF2C382C),
              outline: const Color(0xFF8C9883),
              outlineVariant: const Color(0xFF3C4937),
            );
    }
    final isColumnMode = FluffyThemes.isColumnMode(context);
    final dividerColor = brightness == Brightness.dark
        ? colorScheme.surfaceContainerHighest
        : colorScheme.surfaceContainer;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      dividerColor: dividerColor,
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          iconColor: colorScheme.onSurface,
          disabledIconColor: colorScheme.onSurface,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorScheme.onSurface.withAlpha(128),
        selectionHandleColor: colorScheme.secondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        filled: true,
        fillColor: colorScheme.surfaceContainerLowest,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(18),
      ),
      chipTheme: ChipThemeData(
        showCheckmark: false,
        backgroundColor: colorScheme.surfaceContainer,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius),
        ),
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: isColumnMode ? 72 : 56,
        surfaceTintColor: Colors.transparent,
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 0,
        actionsPadding: isColumnMode
            ? const EdgeInsets.symmetric(horizontal: 16.0)
            : null,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness.reversed,
          statusBarBrightness: brightness,
          systemNavigationBarIconBrightness: brightness.reversed,
          systemNavigationBarColor: colorScheme.surface,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: colorScheme.primary),
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.primary),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        strokeCap: StrokeCap.round,
        color: colorScheme.primary,
        refreshBackgroundColor: colorScheme.primaryContainer,
      ),
      snackBarTheme: isColumnMode
          ? const SnackBarThemeData(
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              width: FluffyThemes.columnWidth * 1.5,
            )
          : const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

extension on Brightness {
  Brightness get reversed =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;
}

extension BubbleColorTheme on ThemeData {
  Color get bubbleColor => brightness == Brightness.light
      ? colorScheme.primary
      : colorScheme.primaryContainer;

  Color get onBubbleColor => brightness == Brightness.light
      ? colorScheme.onPrimary
      : colorScheme.onPrimaryContainer;

  Color get secondaryBubbleColor => HSLColor.fromColor(
    brightness == Brightness.light
        ? colorScheme.tertiary
        : colorScheme.tertiaryContainer,
  ).withSaturation(0.5).toColor();
}
