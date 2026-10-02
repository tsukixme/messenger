<!-- SPDX-FileCopyrightText: 2026 Contributors to Tildes -->
<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

# S4 — сборки приложения и веб-версия

Дата: 2026-10-02. **Подготовлены изменения и PR; S4 не завершён. Локальная подготовка web остановлена после двух неудачных попыток.**

## Сделано

- Ветка `ci-builds` создана от чистого `main` приложения, исходный commit `b020e52c907390bb64d86e0045d00c59a86584bd`.
- Единственное значение встроенного сервера заменено в `lib/config/app_config.dart`, `AppConfig.defaultHomeserver`: `herbicide-ninth-reliance.ngrok-free.dev`. Домен не дублируется в другом коде приложения.
- Скопирован workflow Claude из `tildes-next.zip`: Android APK, web, iOS без подписи. Триггеры сохранены: `workflow_dispatch` и push в `main`; iOS — `continue-on-error: true`.
- Одно обоснованное дополнение к workflow: web job устанавливает Rust nightly, `rust-src`, `wasm32-unknown-unknown`. FRB 2.13 использует nightly `-Z build-std`; исходный workflow устанавливал только stable. [FRB executor](https://raw.githubusercontent.com/fzyzcjy/flutter_rust_bridge/v2.13.0/frb_dart/lib/src/cli/build_web/executor.dart), [Cargo build-std](https://doc.rust-lang.org/cargo/reference/unstable.html#build-std).
- Flutter 3.47.4 / Dart 3.13.3 установлены в локальном tooling проекта из официального Windows-архива, SHA256 сверён с release manifest. Версия совпадает с `.tool_versions.yaml`. Также подготовлены yq и отдельное Rust-окружение проекта; глобальный default host/toolchain не менялся.
- Серверная конфигурация подготовлена отдельно: [messenger-server PR #3](https://github.com/tsukixme/messenger-server/pull/3). На ВМ она пока не применена, настоящий web build не опубликован.
- Существующие иконки, авторы, лицензия и поведение входа сохранены. S5 и выбор способа подписания iOS не выполнялись.

Все изменённые файлы этого PR: `lib/config/app_config.dart`, `.github/workflows/tildes-builds.yml`, `docs/reports/S4-codex.md`. Генерируемые plugin registrants восстановлены; `pubspec.lock` не изменён. SDK, журналы, вспомогательные файлы и секреты не входят в PR.

## Вывод проверки

| Проверка | Результат |
|---|---|
| Официальный SDK и manifest | Flutter 3.47.4 stable, Dart 3.13.3; SHA256 архива совпал |
| `flutter pub get --enforce-lockfile` | Exit 0; lockfile не изменён |
| Исходный `flutter analyze --no-pub` | Exit 0, `No issues found!`, 26,4 с |
| `flutter analyze --no-pub` после замены домена | Exit 0, `No issues found!`, 14,2 с; новых замечаний нет |
| YAML workflow | Прочитан; pin Flutter, список jobs, триггеры и optional iOS проверены |
| `scripts/prepare-web.sh`, попытка 1 | Exit 128: Git из Git Bash не разрешил github.com; компиляция не началась |
| Проверка другим уже используемым Git | `ls-remote` нужного тега — exit 0; Windows DNS также разрешает github.com |
| `scripts/prepare-web.sh`, попытка 2, с этим Git в PATH | Git clone успешен; FRB codegen 2.13.0 собран и установлен; затем exit 1, `FormatException: Unexpected extension byte` при `where.exe wasm-pack` |
| `flutter test --no-pub` | Exit 1 до выполнения тестов: CMake-зависимость webcrypto не собрана; тесты не считаются пройденными |
| `flutter build web --release` | Не запускался после неуспешной обязательной подготовки |
| GitHub jobs android / web / ios-unsigned | Не запускались: новый workflow отсутствует в default branch |
| APK на телефоне, браузерная авторизация, обмен между двумя устройствами | Не проверены; это не заменяется успешной Matrix API-проверкой S3 |

Полный traceback завершения второй попытки подготовки web:

```text
flutter_rust_bridge_codegen build-web --dart-root dart --rust-root $(readlink -f rust) --release
> where.exe wasm-pack (pwd: null, env: null)
Unhandled exception:
FormatException: Unexpected extension byte (at offset 0)
#0      _Utf8Decoder.convertChunked (dart:convert-patch/convert_patch.dart:1963:7)
#1      _Utf8ConversionSink.addSlice (dart:convert/string_conversion.dart:313:28)
#2      _Utf8ConversionSink.add (dart:convert/string_conversion.dart:309:5)
#3      _ConverterStreamEventSink.add (dart:convert/chunked_conversion.dart:70:18)
#4      _SinkTransformerStreamSubscription._handleData (dart:async/stream_transformers.dart:115:24)
#5      _RootZone.runUnaryGuarded (dart:async/zone.dart:963:10)
#6      _BufferingStreamSubscription._sendData (dart:async/stream_impl.dart:381:11)
#7      _BufferingStreamSubscription._add (dart:async/stream_impl.dart:312:7)
#8      _SyncStreamControllerDispatch._sendData (dart:async/stream_controller.dart:798:19)
#9      _StreamController._add (dart:async/stream_controller.dart:663:7)
#10     _StreamController.add (dart:async/stream_controller.dart:618:5)
#11     _Socket._onData (dart:io-patch/socket_patch.dart:2906:41)
#12     _RootZone.runUnaryGuarded (dart:async/zone.dart:963:10)
#13     _BufferingStreamSubscription._sendData (dart:async/stream_impl.dart:381:11)
#14     _BufferingStreamSubscription._add (dart:async/stream_impl.dart:312:7)
#15     _SyncStreamControllerDispatch._sendData (dart:async/stream_controller.dart:798:19)
#16     _StreamController._add (dart:async/stream_controller.dart:663:7)
#17     _StreamController.add (dart:async/stream_controller.dart:618:5)
#18     new _RawSocket.<anonymous closure> (dart:io-patch/socket_patch.dart:2344:31)
#19     _NativeSocket.issueReadEvent.issue (dart:io-patch/socket_patch.dart:1679:14)
#20     _microtaskLoop (dart:async/schedule_microtask.dart:40:35)
#21     _startMicrotaskLoop (dart:async/schedule_microtask.dart:49:5)
#22     _runPendingImmediateCallback (dart:isolate-patch/isolate_patch.dart:127:13)
#23     _RawReceivePort._handleMessage (dart:isolate-patch/isolate_patch.dart:193:5)
Error: Fail to execute command, please see logs above for details.
```

Ошибка `flutter test`:

```text
Building assets for package:webcrypto failed.
Exception: Failed to generate CMake project: CMake Error at CMakeLists.txt:19 (project):
  Generator
    Ninja
  does not support platform specification, but platform
    x64
  was specified.
CMake Error: CMAKE_C_COMPILER not set, after EnableLanguage
CMake Error: CMAKE_CXX_COMPILER not set, after EnableLanguage
Building native assets failed. See the logs for more details.
```

## Проблемы

- Новый workflow нельзя впервые запустить вручную из одной PR-ветки: GitHub требует наличие `workflow_dispatch` в default branch. [Документация GitHub](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow). Поэтому заявление о зелёных сборках пока было бы неверным.
- Вариант A: после ревью Claude и явного подтверждения владельца слить workflow в `main`, затем вручную выполнить предусмотренные Ubuntu/macOS jobs. Вариант B: отдельно согласовать временный ограниченный trigger на PR/ветку для проверки до merge. В этом PR выбранный Claude набор триггеров сохранён; новый trigger молча не добавлялся.
- Подготовка Windows web провалилась дважды на разных стадиях. По правилу владельца операция остановлена. Третья попытка требует разрешения продолжить. Возможные пути — отдельно проверенный обход вывода `where.exe` в локальном процессе или получение web-артефакта Ubuntu CI; менять Dart/FRB зависимость без решения архитектора нельзя.
- `flutter doctor` подтвердил отсутствие Visual Studio C++ и JDK в текущем окружении; Windows native tests не подтверждены. Отдельную проблему CMake Ninja/x64 нельзя исправлять переписыванием приложения. Установка Build Tools/согласия и выбор окружения требуют отдельного решения.
- Android workflow сохраняет предусмотренный fallback release → debug. Зелёный job сам по себе не доказывает успешный release: в отчёте после запуска нужно указать, какой APK собран. Не подключались сертификаты или ключи релизной подписи.
- Бесплатный ngrok может показать Visit Site в браузере. Фактическое поведение web ещё не проверено.

## Что дальше

1. Claude ревьюит оба S4 PR и замечания окружения. Владелец передаёт его ответ; merge выполняется только после явного «Claude одобрил» по правилам проекта.
2. После разрешённого запуска проверить Android и web CI; для сбоя unsigned iOS сохранить полный лог и соблюдать лимит двух исправлений. Установку на iPhone неподписанный IPA сам по себе не подтверждает.
3. Получить настоящий `build/web`, скопировать по строгому SSH на ВМ, применить серверный патч и проверить приложение, API и ngrok в браузере. Серверные аккаунты admin/demo1–demo4 уже созданы владельцем, S3 API-обмен принят.
4. Владелец устанавливает APK и проверяет вход и обмен между двумя устройствами, вводя свои demo-пароли сам. Обновить отчёт и статус только после фактических результатов; S5 не выполнять.
