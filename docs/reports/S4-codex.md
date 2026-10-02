<!-- SPDX-FileCopyrightText: 2026 Contributors to Tildes -->
<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

# S4 — сборки приложения и веб-версия

Дата: 2026-10-02. Android и web успешно собраны в CI. PR остаётся черновиком: публикация web на сервере и проверки устройств ещё не выполнены; слияние требует сообщения владельца «Claude одобрил».

## Сделано

- Сервер пилота указан в одном месте: `lib/config/app_config.dart`, `AppConfig.defaultHomeserver` = `herbicide-ninth-reliance.ngrok-free.dev`.
- Workflow из `tildes-next.zip` собирает Android APK, web zip и существующий unsigned iOS artifact. Flutter закреплён на 3.47.4, права `contents: read`, артефакты хранятся 14 дней.
- Web устанавливает nightly, `rust-src`, `wasm32-unknown-unknown` и явно `cargo install wasm-pack --locked`, как поручено после T28. В успешном запуске установлен wasm-pack 0.15.0.
- Android проверяет каждый APK через `apksigner verify --print-certs`. Владелец прямо утвердил внешний commit `1c4e507`: временный release-ключ по существующему signing config, Gradle `-Xmx4g -XX:MaxMetaspaceSize=1g`, target `android-arm64`. Приватный ключ создаётся в runner и не публикуется.
- Владелец выбрал вариант B: временный push-триггер `ci-builds` позволил проверить сборки до merge. После успешных Android/web он удалён: окончательные триггеры — `workflow_dispatch` и push в `main`. Сами jobs совпадают с успешным commit; окончательный commit с отчётом и восстановленным триггером отдельно не собирался.
- iOS job не изменялся. Иконки, авторы и AGPL сохранены; S5 и WhatsApp отложены.

Все изменённые файлы PR: `lib/config/app_config.dart`, `.github/workflows/tildes-builds.yml`, `docs/reports/S4-codex.md`. Зависимости/lockfile и код входа не менялись. REUSE для документов — отдельный [PR #3](https://github.com/tsukixme/messenger/pull/3); серверная публикация web — отдельный [messenger-server PR #3](https://github.com/tsukixme/messenger-server/pull/3), на ВМ пока не применённый.

## Вывод проверки

Успешный [запуск 36970952993](https://github.com/tsukixme/messenger/actions/runs/36970952993), commit `1c4e5073880086f45349a70421ebe63d0b0f9224`:

| Проверка | Результат |
|---|---|
| [Android job](https://github.com/tsukixme/messenger/actions/runs/36970952993/job/110724612597) | Success; `assembleRelease`, `app-release.apk` 102 994 755 байт; debug fallback не использован |
| Проверка подписи | Success; `apksigner verify --print-certs`, сертификат Tildes Pilot |
| [Web job](https://github.com/tsukixme/messenger/actions/runs/36970952993/job/110724612967) | Success; prepare-web и `flutter build web --release`, ZIP опубликован |
| Неизменённый iOS job | Success автоматически; unsigned artifact не проверялся на устройстве |
| Скачанные Android/web артефакты | SHA-256 внешних ZIP совпали с digest GitHub; APK извлечён и проверен через aapt/ZIP |
| APK | Название `Tildes`, package `kz.tildes.chat`, min SDK 24, target SDK 36; `libflutter.so` и `libapp.so` только `arm64-v8a` |
| YAML / shell | YAML прочитан, все run-блоки прошли `bash -n`; jobs совпадают с успешным commit, iOS сохранён |
| Analyze | Ранее до/после единственной правки домена: `No issues found!`; код приложения с тех пор не менялся |
| REUSE / анализ / тесты | В отдельном [Linux code_tests PR #3](https://github.com/tsukixme/messenger/actions/runs/36969521746/job/110720360494): Check licenses success, анализ без замечаний, 4/4 Flutter tests |
| Web smoke | Локально открыт первый успешный web-артефакт: стартовый экран Tildes, JS ошибок нет; предупреждение FRB о cross-origin headers. Между успешными web-запусками код lib/web не менялся |

Артефакты второго запуска:

- [Android APK](https://github.com/tsukixme/messenger/actions/runs/36970952993/artifacts/11211308320). SHA-256 ZIP: `c7e89ff7bd294da5003280f8faa606545c899328ecdc54b6b23d24cf1e08a3a6`; извлечённого APK: `bb7f421133fc383bb8615d8565e81965fd2451225a68fe0dda2584c358d55cac`.
- [Web ZIP](https://github.com/tsukixme/messenger/actions/runs/36970952993/artifacts/11211762838). SHA-256 внешнего ZIP: `869c193a4c46dbac938c87a7624ce1e103b04d4f5b47392e7c347b6b41890670`.

История CI: [первый запуск 36969567480](https://github.com/tsukixme/messenger/actions/runs/36969567480) дал зелёный web, но Android release не нашёл `dummy.keystore`, а debug fallback завершился `JetifyTransform / Java heap space` в `checkDebugDuplicateClasses`. Полный лог сохранён локально. Следующий запуск с одобренным владельцем внешним патчем успешен: двух подряд неудач на одной ошибке не было.

## Проблемы

- APK использует новый временный ключ при каждом запуске; обычное обновление поверх другой сборки может потребовать удаления приложения и потери его локальных данных. Вариант явно выбран владельцем. Постоянный ключ для обновлений/публикации — отдельное решение. Альтернатива debug для всех архитектур с увеличенным heap обсуждена, владелец её не выбрал.
- Поддерживаемая архитектура приложения — arm64. Некоторые библиотеки плагинов включены также для других ABI: `aapt native-code` перечисляет четыре ABI, но Flutter engine и скомпилированное приложение имеются только для arm64; поддержку остальных это не подтверждает.
- Общие upstream проверки PR #2 могут оставаться красными, пока отдельное правило REUSE из PR #3 не попадёт в main. Зелёные Tildes builds не означают, что все проверки PR #2 зелёные. Matrix Notification не менялся.
- Локальная Windows prepare-web ранее остановлена после двух ошибок на разных стадиях (DNS Git Bash, затем FRB UTF-8/where.exe); дальнейшие попытки не выполнялись. Windows Flutter tests остановились до выполнения тестов из-за webcrypto/CMake. Ubuntu CI подтверждён отдельно.
- Предупреждение FRB о cross-origin headers требует отдельного серверного ревью. Стартовый экран не подтверждает работу E2EE, media, входа и обмена сообщениями в браузере. Заголовки рабочего nginx не менялись.
- APK на телефоне, обмен между двумя устройствами и установка iOS не проверены. Несигнированный iOS artifact сам по себе не подтверждает установку на iPhone. Настоящий web build на публичном сервере пока не опубликован.

## Что дальше

1. Получить ревью Claude по PR приложения #2, отдельному REUSE PR #3 и серверным PR. Слияние только после явного сообщения владельца «Claude одобрил».
2. После разрешённой интеграции REUSE повторить общие PR-проверки при необходимости; build steps Android/web уже проверены на указанном commit. Optional tests job не добавлен ради минимального scope: существующий Linux code_tests проверен отдельно.
3. После ревью опубликовать проверенный web build по серверному PR #3 и проверить публичную страницу, вход и обмен между устройствами. Решения по заголовкам и подписанию iOS сначала согласовать с владельцем. WhatsApp, шаги S3 6в/7/8 и S5 остаются отложенными.
