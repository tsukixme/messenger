// SPDX-FileCopyrightText: 2026 Contributors to Tildes
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/widgets/theme_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('New installations use the brand color', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await AppSettings.init(loadWebConfigFile: false);
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    final controller = tester.state<ThemeController>(find.byType(ThemeBuilder));
    expect(controller.primaryColor, AppConfig.primaryColor);
  });

  testWidgets('A previously selected color is preserved', (tester) async {
    const selected = Color(0xFF1565C0);
    SharedPreferences.setMockInitialValues({'primary_color': 0xFF1565C0});
    await AppSettings.init(loadWebConfigFile: false);
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    final controller = tester.state<ThemeController>(find.byType(ThemeBuilder));
    expect(controller.primaryColor, selected);
  });

  testWidgets('A legacy system color selection is preserved', (tester) async {
    SharedPreferences.setMockInitialValues({
      AppSettings.colorSchemeSeedInt.key: 0xFF6200EE,
    });
    await AppSettings.init(loadWebConfigFile: false);
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    expect(
      tester.state<ThemeController>(find.byType(ThemeBuilder)).primaryColor,
      isNull,
    );
  });

  testWidgets('An explicit brand choice overrides the legacy setting', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      AppSettings.colorSchemeSeedInt.key: AppConfig.colorSchemeSeed,
      'primary_color_use_system_colors': false,
    });
    await AppSettings.init(loadWebConfigFile: false);
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    expect(
      tester.state<ThemeController>(find.byType(ThemeBuilder)).primaryColor,
      AppConfig.primaryColor,
    );
  });

  testWidgets('Explicit system colors persist after restart', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await AppSettings.init(loadWebConfigFile: false);
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    final controller = tester.state<ThemeController>(find.byType(ThemeBuilder));
    await controller.setPrimaryColor(null);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    final restarted = tester.state<ThemeController>(find.byType(ThemeBuilder));
    expect(restarted.primaryColor, isNull);
    await restarted.setPrimaryColor(AppConfig.primaryColor);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    expect(
      tester.state<ThemeController>(find.byType(ThemeBuilder)).primaryColor,
      AppConfig.primaryColor,
    );
  });
}
