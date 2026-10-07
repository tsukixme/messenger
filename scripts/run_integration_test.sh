#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Contributors to Orda
#
# SPDX-License-Identifier: AGPL-3.0-or-later

set -euo pipefail

adb logcat -c
adb logcat -v threadtime AndroidRuntime:E flutter:I FlutterJNI:I libc:E '*:S' &
logcat_pid=$!
trap 'kill "$logcat_pid" 2>/dev/null || true' EXIT

timeout --signal=INT --kill-after=30s 45m flutter drive --verbose \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/mobile_test.dart
