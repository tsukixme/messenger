// SPDX-FileCopyrightText: 2026 Contributors to Tildes
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/widgets/theme_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('New installations use the brand color', (tester) async {
    SharedPreferences.setMockInitialValues({});
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
    await tester.pumpWidget(
      ThemeBuilder(builder: (_, _, _) => const SizedBox()),
    );
    await tester.pumpAndSettle();
    final controller = tester.state<ThemeController>(find.byType(ThemeBuilder));
    expect(controller.primaryColor, selected);
  });

  testWidgets('Explicit system colors persist after restart', (tester) async {
    SharedPreferences.setMockInitialValues({});
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
