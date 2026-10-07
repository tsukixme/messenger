// SPDX-FileCopyrightText: 2019-Present Christian Kußowski
// SPDX-FileCopyrightText: 2019-Present Contributors to FluffyChat
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

abstract class AppConfig {
  static const String applicationName = 'Орда';
  static const String licenseAttribution =
      'Орда основана на FluffyChat (AGPL-3.0)';
  // Shared fallback for Android, iOS and web; keep the deployment domain here.
  static const String defaultHomeserver =
      'herbicide-ninth-reliance.ngrok-free.dev';
  static const String iosAppGroup = 'group.kz.tildes.chat';
  // Personal Team builds keep encrypted data in their own app sandbox.
  static const bool iosDemo = bool.fromEnvironment('ORDA_IOS_DEMO');

  static const Color primaryColor = Color(0xFF261386);

  static const Color chatColor = primaryColor;
  static const double messageFontSize = 16.0;
  static const bool allowOtherHomeservers = true;
  static const bool enableRegistration = true;
  static const bool hideTypingUsernames = false;

  static const String inviteLinkPrefix = 'https://matrix.to/#/';
  static const String deepLinkPrefix = 'im.fluffychat://chat/';
  static const String schemePrefix = 'matrix:';
  static const String pushNotificationsChannelId = 'fluffychat_push';
  static const String pushNotificationsAppId = 'chat.fluffy.fluffychat';
  static const double borderRadius = 18.0;
  static const double spaceBorderRadius = 11.0;
  static const double columnWidth = 360.0;

  static const String appId = 'im.fluffychat.app';
  static const String appOpenUrlScheme = 'im.fluffychat';
  static const String appSsoUrlScheme = 'im.fluffychat.auth';
  // Identifies the notification activation callback on Windows. Never change!
  static const String windowsNotificationGuid =
      '4894dfda-c70a-4ebc-b139-acae55f3988d';

  static const String sourceCodeUrl = 'https://github.com/tsukixme/messenger';
  static const String supportUrl =
      'https://github.com/tsukixme/messenger/issues';
  static const String changelogUrl =
      'https://github.com/tsukixme/messenger/blob/main/CHANGELOG.md';
  static const String latestReleaseApiUrl = '';

  static const Set<String> defaultReactions = {'👍', '❤️', '😂', '😮', '😢'};

  static final Uri newIssueUrl = Uri(
    scheme: 'https',
    host: 'github.com',
    path: '/tsukixme/messenger/issues/new',
  );

  static const String mainIsolatePortName = 'main_isolate';
  static const String pushIsolatePortName = 'push_isolate';
  static const String pushHelperCrashReportKey = 'push_helper_crash_report';

  static const String vodozemacVersion = '0.8.1';
}
