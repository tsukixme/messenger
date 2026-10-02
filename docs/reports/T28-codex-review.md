<!-- SPDX-FileCopyrightText: 2026 Contributors to Tildes -->
<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

## Сделано

2026-10-02: исходный отчёт владельца сохранён без редактирования как
`docs/reports/T28-Claude.md`; SHA-256 обоих файлов:
`40e0934836c04d84370c8510fe410ac73ec098a897affc00add60892f767c7fe`.
Самостоятельно прочитаны текущие workflow, REUSE.toml и оба серверных скрипта.
ВМ доступна через SSH со строгой проверкой ключа; четыре сервиса работают.
Свободно 10 290 294 784 байта на разделе с резервными копиями на момент проверки.

## Вывод проверки

**Принято с уточнениями.** Отсутствие общего правила лицензирования документов,
проверки длины пароля и проверки свободного места подтверждены по коду.
Локальный REUSE 6.2.0 подтвердил 19 документов без метаданных (включая полученный
отчёт); историческое число 17 из отчёта относится к прежнему commit.
Windows checkout дополнительно представляет Git-симлинк `fastlane/metadata`
обычным файлом; это особенность checkout, а не новая ошибка лицензии документа.

Уточнения к предположениям отчёта:

- FRB 2.13.0 автоматически вызывает `cargo install wasm-pack`, если инструмента
  нет. Его отсутствие само по себе не доказывает провал Ubuntu CI. Владелец
  прямо разрешил явную установку с `--locked`; Ubuntu CI затем прошёл с
  wasm-pack 0.15.0, см. [S4](https://github.com/tsukixme/messenger/blob/ci-builds/docs/reports/S4-codex.md).
  [Исходник FRB](https://raw.githubusercontent.com/fzyzcjy/flutter_rust_bridge/v2.13.0/frb_dart/lib/src/cli/build_web/executor.dart).
- `--no-codesign` в используемом Flutter отключает требования подписи Xcode.
  Наличие App Groups само по себе не доказывает ошибку компиляции iOS.
  [Исходник Flutter](https://raw.githubusercontent.com/flutter/flutter/9584c6713b324636289d067944a46fd6b49df14b/packages/flutter_tools/lib/src/ios/mac.dart).
- `apksigner verify --print-certs` проверяет подпись, но не установку на телефон
  и не соответствие ключу будущей публикации. Debug APK также подписывается.
  [Документация Android](https://developer.android.com/tools/apksigner).
- В отдельном временном nginx-контейнере проверен конфиг серверного PR #3 с
  пустым web: `/` дал HTTP 403, `/index.html` и `/missing-route` — HTTP 404.
  Контейнер удалён, рабочий nginx не менялся. Фактическая публикация web ещё
  не выполнена.

## Проблемы

На момент первоначальной проверки зелёные сборки ещё не были подтверждены;
новые результаты записываются в S4. Проверки физических устройств не выполнены. Первичная
Windows-ошибка webcrypto/CMake не исправлялась; конкретную причину Ninja/x64
нельзя считать доказанной только отсутствием Visual Studio. iOS и настройки
Matrix Notification по текущему поручению не меняются. Полного восстановления
сервера из копии не было; прежняя проверка SQLite не заменяет его.

## Что дальше

Владелец выбрал B и отдельно подтвердил внешний вариант временного release-ключа
и arm64. [Android/web CI](https://github.com/tsukixme/messenger/actions/runs/36970952993)
успешен на `1c4e507`; после него временный push `ci-builds` удалён commit
`e2b033254`, восстановлен `main`. Build jobs не изменились. Первый Android запуск
упал, второй прошёл; двух подряд неудач на одной ошибке не было.

Отдельный [PR #3](https://github.com/tsukixme/messenger/pull/3) добавил REUSE
для `docs/**`: Linux Check licenses, analyze и 4/4 Flutter tests прошли.
[Серверный PR #2](https://github.com/tsukixme/messenger-server/pull/2) добавил
минимум 12 символов и предварительную проверку места: 7/7 Linux tests прошли,
код ещё не установлен в рабочие скрипты ВМ. Полные результаты и ограничения —
в [серверном отчёте](https://github.com/tsukixme/messenger-server/blob/main/docs/reports/T28-codex.md)
и S4. Публикация web, физические устройства и полное восстановление копии
остаются непроверенными.

**Слияния запрещены до отдельного сообщения владельца «Claude одобрил».**
