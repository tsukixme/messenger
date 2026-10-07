// SPDX-FileCopyrightText: 2026 Contributors to Орда
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/pages/sign_in/view_model/sign_in_view_model.dart';
import 'package:fluffychat/utils/background_push.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await AppSettings.init(loadWebConfigFile: false);
  });

  test(
    'our server is preset and inherited upstream services are disabled',
    () async {
      expect(AppSettings.presetHomeserver.value, AppConfig.defaultHomeserver);
      expect(AppSettings.pushNotificationsGatewayUrl.value, isEmpty);
      expect(AppSettings.fallbackLiveKitInstance.value, isEmpty);
      expect(AppSettings.checkForUpdates.value, isFalse);
      expect(AppConfig.latestReleaseApiUrl, isEmpty);

      await AppSettings.pushNotificationsGatewayUrl.setItem(
        'https://push.fluffychat.im/_matrix/push/v1/notify',
      );
      await AppSettings.fallbackLiveKitInstance.setItem(
        'https://livekit-jwt.fluffy.chat',
      );
      expect(AppSettings.pushNotificationsGatewayUrl.value, isEmpty);
      expect(AppSettings.fallbackLiveKitInstance.value, isEmpty);
      await AppSettings.fallbackLiveKitInstance.setItem(
        'https://rtc.orda.example',
      );
      expect(
        AppSettings.fallbackLiveKitInstance.value,
        'https://rtc.orda.example',
      );
    },
  );

  test(
    'an empty gateway prevents pusher requests even with an endpoint',
    () async {
      await AppSettings.pushNotificationsGatewayUrl.setItem('');
      final client = _PusherClient();
      await BackgroundPush.clientOnly([client]).setupPusher(
        client: client,
        gatewayUrl:
            'https://matrix.gateway.unifiedpush.org/_matrix/push/v1/notify',
        token: 'test-token',
      );
      expect(client.pusherRequests, 0);
    },
  );

  test('the local homeserver list still accepts a custom address', () {
    final model = SignInViewModel();
    addTearDown(model.dispose);
    expect(
      model.value.publicHomeservers.data!.single.name,
      AppConfig.defaultHomeserver,
    );
    model.filterTextController.text = 'https://matrix.orda.example';
    expect(
      model.value.filteredPublicHomeservers.single.name,
      'https://matrix.orda.example',
    );
  });
}

class _PusherClient extends Fake implements Client {
  int pusherRequests = 0;

  @override
  Future<List<Pusher>?> getPushers() async {
    pusherRequests++;
    return [];
  }
}
