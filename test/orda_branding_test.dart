// SPDX-FileCopyrightText: 2026 Contributors to Орда
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'inherited branding is ignored and custom settings are preserved',
    () async {
      SharedPreferences.setMockInitialValues({
        AppSettings.applicationName.key: 'Tildes',
        AppSettings.website.key: 'https://fluffychat.im',
        AppSettings.privacyPolicy.key: 'https://fluffychat.im/privacy',
        AppSettings.tos.key: 'https://orda.example/terms',
        AppSettings.logoUrl.key: 'https://orda.example/logo.png',
        AppSettings.pushNotificationsGatewayUrl.key:
            'https://push.example/notify',
      });
      await AppSettings.init(loadWebConfigFile: false);

      expect(AppSettings.applicationName.value, 'Орда');
      expect(AppSettings.website.value, isEmpty);
      expect(AppSettings.privacyPolicy.value, isEmpty);
      expect(AppSettings.tos.value, 'https://orda.example/terms');
      expect(AppSettings.logoUrl.value, 'https://orda.example/logo.png');
      expect(
        AppSettings.pushNotificationsGatewayUrl.value,
        'https://push.example/notify',
      );
    },
  );

  testWidgets('About and licenses retain attribution and the repository link', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      AppSettings.applicationName.key: AppConfig.applicationName,
    });
    await AppSettings.init(loadWebConfigFile: false);
    PackageInfo.setMockInitialValues(
      appName: AppConfig.applicationName,
      packageName: 'fluffychat',
      version: '2.10.0',
      buildNumber: '3568',
      buildSignature: '',
    );
    LicenseRegistry.reset();
    LicenseRegistry.addLicense(() async* {
      yield LicenseEntryWithLineBreaks(['test'], 'AGPL-3.0');
    });
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              key: const Key('open_about'),
              onPressed: () => PlatformInfos.showDialog(context),
              child: const Text('About'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('open_about')));
    await tester.pumpAndSettle();
    final about = find.byType(AboutDialog);
    expect(about, findsOneWidget);
    expect(tester.widget<AboutDialog>(about).applicationName, 'Орда');
    expect(
      find.text(AppConfig.licenseAttribution, findRichText: true),
      findsWidgets,
    );
    expect(find.text('GitHub', findRichText: true), findsWidgets);

    await tester.tap(find.text('View licenses', findRichText: true).first);
    await tester.pumpAndSettle();
    expect(find.byType(LicensePage), findsOneWidget);
    final licenses = find.byType(LicensePage);
    expect(
      find.descendant(
        of: licenses,
        matching: find.text(AppConfig.licenseAttribution, findRichText: true),
      ),
      findsWidgets,
    );
    final github = find
        .descendant(
          of: licenses,
          matching: find.text('GitHub', findRichText: true),
        )
        .first;
    final link = tester.widget<TextButton>(
      find.ancestor(of: github, matching: find.byType(TextButton)).first,
    );
    expect(link.onPressed, isNotNull);
    expect(AppConfig.sourceCodeUrl, 'https://github.com/tsukixme/messenger');
    expect(tester.takeException(), isNull);
  });
}
