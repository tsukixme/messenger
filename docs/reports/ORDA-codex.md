# Орда — шаг 2а и присланные иконки

Дата: 7 октября 2026 года. Репозиторий: https://github.com/tsukixme/messenger.
Базовый коммит: `cf8ff0baa6ef4eaefdb4443ce63dfedee1bf7d13`, ветка изменений: `rebrand-orda`.

Выполнен запрос на удаление FluffyChat из интерфейса. После получения `orda_icon_1024.png` и `orda_icon_foreground_1024.png` также подготовлены иконки. Другие шаги из приложенной справки не запускались: сервер, подпись, workflow сборок, идентификаторы приложения не менялись. Слияние в main требует отдельного «Claude одобрил».

## Найденные видимые упоминания и ссылки

| Где найдено до изменения | Что видел пользователь | Результат |
| --- | --- | --- |
| `lib/config/setting_keys.dart:56`, `config.sample.json:2` | Имя Tildes, сайт FluffyChat, URL логотипа и документов | Единое имя `AppConfig.applicationName = 'Орда'`; сайт, политика, условия и удалённый логотип по умолчанию пустые. `privacyUrl` в образце заменён действующим ключом `privacyPolicy`. |
| `lib/utils/platform_infos.dart`, `lib/widgets/layouts/login_scaffold.dart` | «О приложении», исходный код и «Справка» вели в upstream | Исходники и справка ведут в репозиторий Орды / его issues. В «О приложении» и стандартной странице лицензий показана строка «Орда основана на FluffyChat (AGPL-3.0)» и действующая кнопка GitHub: https://github.com/tsukixme/messenger. |
| `lib/pages/intro/intro_page.dart`, `lib/pages/settings/settings_view.dart`, `login_scaffold.dart` | Ссылка на `https://fluffychat.im/privacy` | Пункт скрыт, пока не настроен собственный адрес политики. |
| `lib/pages/chat_list/client_chooser_button.dart:83-94,214-218` | «Поддержать FluffyChat», переход к пожертвованиям | Пункт меню, обработчик и enum-вариант удалены. |
| `lib/utils/show_update_snackbar.dart` | Баннер с надписью fluffychat, кнопка поддержки и ссылка на changelog FluffyChat | Заголовок «Орда», кнопка пожертвования удалена, changelog открывается в репозитории Орды. Проверка обновлений Windows сохранена отдельно как внешний сервис. |
| `lib/pages/chat_encryption_settings/chat_encryption_settings_view.dart` | «Справка» на Ko-fi об шифровании FluffyChat | Кнопка удалена. |
| `lib/pages/chat/sticker_picker_dialog.dart` | «Обзор» на инструкцию FluffyChat о стикерах | Кнопка удалена; выбор и отправка существующих стикеров сохранены. |
| `lib/utils/background_push.dart` | Ссылка «как получить push без Google» на Ko-fi | Ссылка удалена, предупреждение о push сохранено. |
| `lib/config/app_config.dart`, `lib/utils/error_reporter.dart`, `lib/utils/init_with_restore.dart` | Создание/поиск ошибки и восстановление сессии ссылались на upstream tracker | Ссылки и поиск issues перенаправлены на `tsukixme/messenger`. |
| `.github/ISSUE_TEMPLATE/config.yml:3-5`, `.github/ISSUE_TEMPLATE/test_report.md:28` | «FluffyChat Community» в меню трекера и название в протоколе тестирования | Ссылка на community удалена, название заменено на Орда. |
| `lib/utils/start_push_foreground_service.dart:71`, ARB `newMessageInFluffyChat` | Заголовки фоновой синхронизации и уведомлений FluffyChat | «Орда», ключ перевода оставлен внутренним. |
| `lib/utils/fluffy_share.dart`, ARB `inviteText` | Инструкция установить FluffyChat с fluffychat.im и Matrix-ссылка с `client=im.fluffychat` | Шаг установки с чужого сайта удалён во всех имеющих его переводах, шаги перенумерованы; подсказка выбора клиента из Matrix-ссылки удалена. `{username}` и `{link}` сохранены. |
| `lib/pages/bootstrap/view_model/bootstrap_view_model.dart:287`, `lib/widgets/matrix.dart:429` | `FluffyChat-Recovery-Key-….txt`, `fluffychat-export-….fluffybackup` | `Orda-Recovery-Key-….txt`, `orda-export-….ordabackup`. Формат содержимого не изменён, импорт не ограничивает расширение и принимает старые файлы. |
| `android/app/src/main/AndroidManifest.xml:31` | Имя Tildes в launcher | Орда; `kz.tildes.chat` сохранён. Отдельного `strings.xml` с названием нет. |
| `ios/Runner/Info.plist`, `ios/FluffyChat Share/Info.plist` | Tildes в имени и разрешениях / share extension | Орда; идентификаторы и App Group сохранены. |
| `ios/Notification Service Extension/NotificationService.swift:125` | Резервное имя «FluffyChat User» | «Орда User». |
| `web/index.html:27,35`, `web/manifest.json:2,3` | Название Tildes в заголовке, PWA и Apple meta tag | Орда. |
| `linux/my_application.cc:56,60`, `windows/runner/main.cpp:30` | Заголовок окна FluffyChat | Орда. |
| `windows/runner/Runner.rc:93,95,98` | Название/описание продукта в свойствах файла | Орда; имя исполняемого файла и copyright сохранены. |
| `windows/installer.iss:16-22,27,69-73` | Название, каталог, ярлыки, сайт, поддержка, обновления | Название и ярлыки Орда, сайт FluffyChat удалён; support/releases ведут в репозиторий Орды. GUID установки и executable сохранены. |
| `macos/Runner/Configs/AppInfo.xcconfig`, `macos/Runner/Info.plist`, Xcode project/scheme | FluffyChat.app и описание разрешения геолокации | Орда.app и Орда; copyright авторов сохранён. |
| `android/fastlane/metadata/android/en-US/{title,full_description}.txt`, `snap/snapcraft.yaml`, `snap/gui/fluffychat.desktop` | Названия в метаданных магазинов, ссылка на сайт и community FluffyChat | Орда; ссылки удалены или заменены исходниками Орды. В runtime прямых ссылок на страницы магазинов FluffyChat не найдено. |
| `assets/logo/mini/banner.png` | Встроенная надпись fluffychat в изображении окна обновления | Изображение больше не используется в интерфейсе. |

Удалённые адреса помощи/поддержки:

- `https://ko-fi.com/post/How-can-I-support-FluffyChat-J2G325WE6I`
- `https://ko-fi.com/post/How-to-use-end-to-end-encryption-in-FluffyChat-A5O725WDR5`
- `https://ko-fi.com/post/How-to-add-a-sticker-pack-to-FluffyChat-N4N01OXATI`
- `https://ko-fi.com/post/How-can-I-get-Push-Notifications-without-Google-N7Q825URG6?fromEditor=true`
- `https://fluffychat.im`, `/privacy`, `/tos`, `/changelog/`, `/assets/favicon.png`
- `https://github.com/krille-chan/fluffychat` и его `/issues`, `/issues/new`, `/releases` в пользовательских ссылках.
- `https://matrix.to/#/#fluffy-space:matrix.org` в метаданных snap и меню GitHub issues.

## Переводы — полный список изменённых сообщений

Проверены все 59 ARB-файлов. Изменены/удалены 239 сообщений в 42 файлах: название, уведомления, приглашения, вводная регистрация, описание шифрования/блокировки, тексты поддержки. Удалены 45 больше не используемых переводов кнопок `supportFluffyChat` / `support` и 34 переводов `discover` для удалённой ссылки на инструкцию по стикерам. Ключи остальных сообщений и ICU-параметры сохранены. Учтены также персидское написание, тамильский перевод названия и финское `FluffyChätissä`.

Номера строк в следующей таблице относятся к базовому коммиту, а не к изменённому файлу.

| Файл | Найденные сообщения (ключ:строка; × — удалено) |
| --- | --- |
| `lib/l10n/intl_ar.arb` | `inviteText:543`, `newMessageInFluffyChat:675`, `discover:2086` ×, `signUpGreeting:2457`, `supportFluffyChat:2476` ×, `support:2477` ×, `possibleByYou:2486`, `newPassphraseDescription:2560` |
| `lib/l10n/intl_be.arb` | `inviteText:926`, `newMessageInFluffyChat:1087`, `discover:2238` ×, `signUpGreeting:2466`, `supportFluffyChat:2486` ×, `support:2487` ×, `possibleByYou:2576`, `newPassphraseDescription:2660` |
| `lib/l10n/intl_ca.arb` | `inviteText:628`, `newMessageInFluffyChat:775`, `noGoogleServicesWarning:800`, `discover:2094` ×, `signUpGreeting:2478`, `supportFluffyChat:2498` ×, `support:2499` × |
| `lib/l10n/intl_cs.arb` | `inviteText:817`, `newMessageInFluffyChat:974`, `signUpGreeting:2329`, `discover:2391` × |
| `lib/l10n/intl_de.arb` | `inviteText:812`, `newMessageInFluffyChat:969`, `discover:2097` ×, `signUpGreeting:2485`, `supportFluffyChat:2507` ×, `support:2508` ×, `possibleByYou:2525`, `newPassphraseDescription:2608` |
| `lib/l10n/intl_en.arb` | `inviteText:989`, `newMessageInFluffyChat:1150`, `discover:2236` ×, `signUpGreeting:2550`, `supportFluffyChat:2570` ×, `support:2571` ×, `possibleByYou:2580`, `newPassphraseDescription:2664` |
| `lib/l10n/intl_eo.arb` | `inviteText:806`, `newMessageInFluffyChat:953`, `noGoogleServicesWarning:988` |
| `lib/l10n/intl_es.arb` | `inviteText:625`, `newMessageInFluffyChat:762`, `discover:2240` ×, `signUpGreeting:2487`, `supportFluffyChat:2507` ×, `support:2508` ×, `possibleByYou:2524` |
| `lib/l10n/intl_et.arb` | `inviteText:817`, `newMessageInFluffyChat:974`, `noGoogleServicesWarning:1009`, `discover:2098` ×, `signUpGreeting:2482`, `supportFluffyChat:2502` ×, `support:2503` ×, `possibleByYou:2517`, `newPassphraseDescription:2619` |
| `lib/l10n/intl_eu.arb` | `inviteText:537`, `newMessageInFluffyChat:669`, `discover:2094` ×, `signUpGreeting:2479`, `supportFluffyChat:2499` ×, `support:2500` ×, `possibleByYou:2516` |
| `lib/l10n/intl_fa.arb` | `newMessageInFluffyChat:1012`, `noGoogleServicesWarning:1294`, `inviteText:1340`, `discover:2173` ×, `signUpGreeting:2469`, `supportFluffyChat:2489` ×, `support:2490` × |
| `lib/l10n/intl_fi.arb` | `about:3`, `inviteText:641`, `newMessageInFluffyChat:779`, `discover:2185` × |
| `lib/l10n/intl_fr.arb` | `inviteText:818`, `newMessageInFluffyChat:975`, `discover:1995` ×, `signUpGreeting:2319`, `supportFluffyChat:2489` ×, `possibleByYou:2510`, `newPassphraseDescription:2592`, `support:2704` × |
| `lib/l10n/intl_ga.arb` | `inviteText:1002`, `newMessageInFluffyChat:1051`, `discover:2209` ×, `signUpGreeting:2485`, `supportFluffyChat:2505` ×, `support:2506` ×, `possibleByYou:2522`, `newPassphraseDescription:2606` |
| `lib/l10n/intl_gl.arb` | `inviteText:817`, `newMessageInFluffyChat:974`, `discover:2095` ×, `signUpGreeting:2479`, `supportFluffyChat:2499` ×, `support:2500` ×, `possibleByYou:2516`, `newPassphraseDescription:2600` |
| `lib/l10n/intl_he.arb` | `inviteText:622`, `newMessageInFluffyChat:1085`, `noGoogleServicesWarning:1090` |
| `lib/l10n/intl_hr.arb` | `inviteText:803`, `newMessageInFluffyChat:950`, `discover:1978` × |
| `lib/l10n/intl_hu.arb` | `inviteText:572`, `newMessageInFluffyChat:709`, `discover:2090` × |
| `lib/l10n/intl_id.arb` | `inviteText:91`, `newMessageInFluffyChat:808`, `discover:2072` ×, `signUpGreeting:2478`, `supportFluffyChat:2498` ×, `support:2499` ×, `possibleByYou:2515`, `newPassphraseDescription:2599` |
| `lib/l10n/intl_it.arb` | `inviteText:693`, `newMessageInFluffyChat:840`, `discover:2003` ×, `supportFluffyChat:2544` × |
| `lib/l10n/intl_ja.arb` | `inviteText:700`, `newMessageInFluffyChat:847`, `signUpGreeting:2243` |
| `lib/l10n/intl_kab.arb` | `newMessageInFluffyChat:755`, `inviteText:1141`, `signUpGreeting:1699`, `discover:1756` × |
| `lib/l10n/intl_ko.arb` | `newMessageInFluffyChat:1060`, `noGoogleServicesWarning:1281`, `inviteText:1496`, `discover:2096` × |
| `lib/l10n/intl_lt.arb` | `newMessageInFluffyChat:699`, `noGoogleServicesWarning:1043`, `inviteText:1464`, `newPassphraseDescription:1904` |
| `lib/l10n/intl_lv.arb` | `inviteText:518`, `newMessageInFluffyChat:843`, `discover:2067` ×, `signUpGreeting:2463`, `support:2473` ×, `supportFluffyChat:2490` ×, `possibleByYou:2496`, `newPassphraseDescription:2698` |
| `lib/l10n/intl_nb.arb` | `inviteText:666`, `newMessageInFluffyChat:813`, `discover:1672` ×, `signUpGreeting:2486`, `supportFluffyChat:2506` ×, `support:2507` ×, `possibleByYou:2523`, `newPassphraseDescription:2587` |
| `lib/l10n/intl_nl.arb` | `inviteText:817`, `newMessageInFluffyChat:974`, `discover:2060` ×, `signUpGreeting:2478`, `supportFluffyChat:2498` ×, `support:2499` ×, `possibleByYou:2513`, `newPassphraseDescription:2599` |
| `lib/l10n/intl_pl.arb` | `inviteText:729`, `newMessageInFluffyChat:871`, `discover:1962` ×, `signUpGreeting:2443`, `supportFluffyChat:2463` ×, `support:2464` ×, `possibleByYou:2516`, `newPassphraseDescription:2600` |
| `lib/l10n/intl_pt_BR.arb` | `inviteText:816`, `newMessageInFluffyChat:973`, `discover:2095` × |
| `lib/l10n/intl_pt_PT.arb` | `inviteText:764`, `newMessageInFluffyChat:921`, `noGoogleServicesWarning:956` |
| `lib/l10n/intl_ro.arb` | `inviteText:717`, `noGoogleServicesWarning:1083`, `newMessageInFluffyChat:1267` |
| `lib/l10n/intl_ru.arb` | `inviteText:817`, `newMessageInFluffyChat:965`, `noGoogleServicesWarning:1000`, `discover:2078` ×, `signUpGreeting:2423`, `supportFluffyChat:2499` ×, `support:2500` ×, `possibleByYou:2526`, `newPassphraseDescription:2663` |
| `lib/l10n/intl_sk.arb` | `inviteText:519`, `newMessageInFluffyChat:646`, `noGoogleServicesWarning:661` |
| `lib/l10n/intl_sr.arb` | `inviteText:769`, `newMessageInFluffyChat:916`, `noGoogleServicesWarning:951` |
| `lib/l10n/intl_sv.arb` | `inviteText:651`, `newMessageInFluffyChat:798`, `noGoogleServicesWarning:828`, `discover:2094` ×, `signUpGreeting:2467`, `supportFluffyChat:2487` ×, `support:2488` ×, `possibleByYou:2497`, `newPassphraseDescription:2581` |
| `lib/l10n/intl_ta.arb` | `discover:693` ×, `newMessageInFluffyChat:967`, `inviteText:1477`, `signUpGreeting:2471`, `supportFluffyChat:2553` ×, `support:2554` ×, `newPassphraseDescription:2642` |
| `lib/l10n/intl_tr.arb` | `inviteText:818`, `newMessageInFluffyChat:975`, `discover:2125` × |
| `lib/l10n/intl_uk.arb` | `inviteText:537`, `newMessageInFluffyChat:664`, `discover:2094` ×, `signUpGreeting:2479`, `supportFluffyChat:2499` ×, `support:2500` ×, `possibleByYou:2514` |
| `lib/l10n/intl_uz.arb` | `inviteText:846`, `newMessageInFluffyChat:1086`, `discover:2151` × |
| `lib/l10n/intl_vi.arb` | `discover:495` × |
| `lib/l10n/intl_zh.arb` | `inviteText:789`, `newMessageInFluffyChat:936`, `noGoogleServicesWarning:971`, `discover:2095` ×, `appLockDescription:2110`, `signUpGreeting:2479`, `supportFluffyChat:2499` ×, `support:2500` ×, `possibleByYou:2514`, `newPassphraseDescription:2598` |
| `lib/l10n/intl_zh_Hant.arb` | `inviteText:688`, `newMessageInFluffyChat:835`, `discover:1627` × |

## Внешние сервисы — решение владельца требуется

Эти настройки не удалены и не переименованы. Вопрос владельцу задан в чате; ответа на момент подготовки отчёта нет. Адреса выписаны из кода; сетевые запросы к этим сервисам специально не отправлялись.

| Адрес / настройка | Назначение по коду | Что сохранено / вопрос |
| --- | --- | --- |
| `https://push.fluffychat.im/_matrix/push/v1/notify` — `AppSettings.pushNotificationsGatewayUrl`, `lib/config/setting_keys.dart:31-34` | Push-шлюз. `BackgroundPush.setupPusher` передаёт этот URL Matrix-серверу при регистрации pusher; формат по умолчанию `event_id_only`. | Сохранён. Оставить временно или предоставить собственный шлюз? Отключение без замены может лишить фоновых уведомлений. |
| `https://livekit-jwt.fluffy.chat` — `fallbackLiveKitInstance`, `lib/utils/matrix_live_kit_calls/matrix_live_kit_call.dart` | Резервный LiveKit/JWT сервис для звонков; SDK сначала ищет конфигурацию у homeserver, затем использует fallback. | Сохранён. Нужен собственный адрес или решение убрать fallback с оценкой доступности звонков. |
| `https://crash.fluffy.chat` — `AppConfig.crashReportEndpoint` | Объявленная конечная точка отчётов об ошибках. По поиску всего `lib/` обращений к этой константе нет: текущий ErrorReporter использует диалог и GitHub issues. | Не удалён как запрошено. Решить, удалять ли неиспользуемую настройку или подключать свой сбор отчётов. |
| `https://api.github.com/repos/krille-chan/fluffychat/releases/latest` — `UpdateNotifier.showUpdateAvailableBanner` | Проверка обновлений Windows, не чаще раза в день. Ищет файл `fluffychat-windows-x64-setup.exe`, может предложить установщик upstream через download URL ответа API. | Сохранены API и имя ожидаемого установщика. Владелец должен решить: отключить проверку или настроить релизы Орды. Пока этот функциональный путь всё ещё может открыть загрузку FluffyChat. |
| `https://raw.githubusercontent.com/krille-chan/fluffychat/refs/heads/main/recommended_homeservers.json` — `AppConfig.homeserverList`, `SignInViewModel` | Загрузка списка рекомендуемых публичных Matrix-серверов на экране выбора сервера. | Сохранён. Оставить или заменить собственным списком/убрать публичный выбор? |
| Firebase project `fluffychat-ef3e8`, bucket `fluffychat-ef3e8.appspot.com`, app ID `im.fluffychat.app` — `ios/Runner/GoogleService-Info.plist`; шаблоны `scripts/add-firebase-messaging.sh` | Настройки Firebase Cloud Messaging upstream. В исходном `BackgroundPush` `firebaseEnabled = false`, код Firebase включается подготовительным скриптом сборки. | Сохранены. Нужен собственный проект Firebase и совместимая конфигурация push. Ключи и токены в отчёт не включены. |

Другие найденные внешние зависимости, не относящиеся к бренду FluffyChat: `https://matrix.gateway.unifiedpush.org/_matrix/push/v1/notify` (UnifiedPush fallback), `matrix.to` (Matrix-приглашения), `https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png` и `www.openstreetmap.org` (карты и геолокация). Их адреса не менялись.

## Конфигурация и лицензии

- В `AppSettingsStringExtension.value` известные старые значения Tildes/FluffyChat заменяются при чтении на Орда; для website/logo/privacy/tos адреса доменов `fluffychat.im` и `fluffy.chat` игнорируются. Это охватывает локальные preferences, web config и MDM, сохраняет собственные значения и не изменяет ключи/хранилище.
- Сайт, политика и условия остаются пустыми заглушками до назначения владельцем. OIDC получает `null` для отсутствующих необязательных URL логотипа и документов; обязательный client URI при отсутствии website берётся из адреса развёрнутого web-приложения или репозитория Орды на мобильных платформах. Выдуманная политика конфиденциальности не добавлялась.
- `LICENSE`, существующие SPDX-заголовки и copyright авторов сохранены. Новые исходники имеют SPDX; новые/заменённые изображения перечислены в отдельном блоке `REUSE.toml` с AGPL-3.0-or-later и Contributors to Орда. Неиспользуемые исторические исходники artwork сохраняют свои исходные атрибуции.
- Dart-пакет `fluffychat`, все существующие ключи `chat.fluffy.*`, `kz.tildes.chat`, deep-link/OAuth схемы, App Group, pusher ID, Windows installer GUID и техническое имя executable не переименованы.
- Значение `AppConfig.defaultHomeserver` / fallback `AppSettings.defaultHomeserver`: `herbicide-ninth-reliance.ngrok-free.dev`; `AppSettings.presetHomeserver`: `''`. В этом шаге не изменены.

## Иконки из присланных файлов

Полноцветный PNG 1024×1024 — RGB без прозрачности, подходит для iOS. Передний слой 1024×1024 имеет alpha. Оба исходных файла сохранены побайтово, без генерации нового рисунка. Использован уже имеющийся `flutter_launcher_icons 0.14.4`; производные размеры и SVG-монохром подготовлены штатными средствами.

- Android: mipmap mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi, adaptive foreground с inset 8%, отдельный фон `#330713` (цвет углов присланной иконки), monochrome для Android 13. Старые векторные cat foreground/monochrome удалены, чтобы не перекрывать новые raster resources.
- Важная область переднего слоя после inset занимает примерно 62% холста и помещается в безопасную область 66%; исходный foreground содержит прозрачные поля.
- Белая иконка уведомлений — упрощённое облако с тремя точками, сделана как Android vector. Используется и для локальных уведомлений, и для foreground service через отдельный meta-data resource.
- iOS: набор AppIcon, включая 1024×1024 без alpha; macOS и Windows: штатные платформенные наборы; snap: иконка launcher.
- Web: favicon 16px, отдельные 16/32/48px, обычные и maskable 192/512px. Maskable имеют непрозрачный фон.
- Внутри приложения: полноцветный logo_mini; mono logo для блокировки и пустой страницы; splash на Android и три размера iOS LaunchImage.
- Цвета темы приложения и web theme/background не изменены. Новый логотип бордово-золотой; согласование цветов интерфейса остаётся отдельным вопросом.

## Проверки и ограничения

- Flutter 3.47.4, Dart 3.13.3 (версия проекта), установлены в рабочую папку.
- `dart format --output=none --set-exit-if-changed` для всех изменённых Dart-файлов и нового теста — PASS.
- `flutter gen-l10n` — успешно. В исходном проекте есть отсутствующие переводы, используются существующие fallback; новых пустых строк не добавлено.
- Проверка всех 59 ARB: нет старого имени/домена в значениях; ICU-параметры сохранены; удалены только ключи кнопок поддержки. Проверены JSON/XML/plist, целостность PNG/ICO, неизменность SPDX, LICENSE, внутренних ключей, адресов сервисов и хешей присланных оригиналов — PASS. Все 100 PNG в assets и платформах успешно декодируются; новые iOS AppIcon — RGB.
- `git diff --check` с `cr-at-eol` для исходного CRLF Windows resource — PASS. `pubspec.lock` и workflow сборки не менялись.
- `flutter analyze --no-pub` — PASS, `No issues found`. В локальной копии закреплённого Matrix SDK `355bf1d2d471ef2ab578d83a14a684cea7c07a1c` отсутствовал один файл динамической регистрации OIDC, хотя он присутствовал в Git index. Это воспроизводило пять ошибок и в исходном, и в изменённом приложении. Недостающий файл восстановлен из того же коммита SDK; версии зависимостей не менялись. После восстановления и исправления обязательного `clientUri` анализ проходит.
- Добавлены два регрессионных теста `test/orda_branding_test.dart`: чтение старых/собственных настроек и отображение атрибуции со ссылкой в About/LicensePage. Их обычный локальный запуск заблокирован native hook `webcrypto`: не найден CMake. Результат тестов не объявляется успешным. `flutter pub get` получил зависимости и сгенерировал локализации, но его последний этап Windows plugins требует включённого symlink support; настройки Windows не менялись.
- `reuse lint` — PASS после явного покрытия `fastlane/metadata` (symlink, который при Windows checkout представлен обычным текстовым файлом) существующей общей аннотацией. Лицензии и копирайты есть для всех проверяемых файлов.
- Release APK/веб/iOS сборки отдельного workflow не запускались: этот запрос — шаг 2а. SHA-256 release APK отсутствует. Автоматические проверки и debug-сборки PR: https://github.com/tsukixme/messenger/pull/5/checks. Debug-сборки workflow запускаются только после успешных проверок кода.

## Открытые вопросы владельцу

1. Сохранить, отключить после оценки последствий или заменить перечисленные сервисы FluffyChat? Нужны целевые адреса push, LiveKit/JWT и собственный проект Firebase; отдельно решение по Windows updater и списку homeserver.
2. Какие адреса назначить сайту, справке, политике и условиям Орды? Сейчас справка ведёт в issues проекта, остальные ссылки скрыты до настройки.
3. Полноценная release-сборка и визуальная проверка входа остаются отдельным следующим шагом. Локальные проблемы анализа в Windows нужно отличать от результатов Linux CI.
4. Подтверждение цветов темы, если требуется согласовать её с новым логотипом; текущие цвета сохранены.

## Изменённые файлы

- `.github/ISSUE_TEMPLATE/config.yml`
- `.github/ISSUE_TEMPLATE/test_report.md`
- `REUSE.toml`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/res/drawable-hdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/drawable-hdpi/ic_launcher_monochrome.png`
- `android/app/src/main/res/drawable-hdpi/splash.png`
- `android/app/src/main/res/drawable-mdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/drawable-mdpi/ic_launcher_monochrome.png`
- `android/app/src/main/res/drawable-mdpi/splash.png`
- `android/app/src/main/res/drawable-xhdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/drawable-xhdpi/ic_launcher_monochrome.png`
- `android/app/src/main/res/drawable-xhdpi/splash.png`
- `android/app/src/main/res/drawable-xxhdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/drawable-xxhdpi/ic_launcher_monochrome.png`
- `android/app/src/main/res/drawable-xxhdpi/splash.png`
- `android/app/src/main/res/drawable-xxxhdpi/ic_launcher_foreground.png`
- `android/app/src/main/res/drawable-xxxhdpi/ic_launcher_monochrome.png`
- `android/app/src/main/res/drawable-xxxhdpi/splash.png`
- `android/app/src/main/res/drawable/ic_launcher_foreground.xml`
- `android/app/src/main/res/drawable/ic_launcher_monochrome.xml`
- `android/app/src/main/res/drawable/orda_notification.xml`
- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`
- `android/app/src/main/res/mipmap-hdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-mdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png`
- `android/app/src/main/res/values/colors.xml`
- `android/fastlane/metadata/android/en-US/full_description.txt`
- `android/fastlane/metadata/android/en-US/title.txt`
- `assets/logo/img/logo.png`
- `assets/logo/img/logo_foreground.png`
- `assets/logo/img/logo_mono.png`
- `assets/logo/img/logo_mono.svg`
- `assets/logo/img/logo_standalone.png`
- `assets/logo/mini/logo_mini.png`
- `assets/logo/mini/logo_mono_mini.png`
- `config.sample.json`
- `docs/reports/ORDA-codex.md`
- `ios/FluffyChat Share/Info.plist`
- `ios/Notification Service Extension/NotificationService.swift`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png`
- `ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png`
- `ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png`
- `ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png`
- `ios/Runner/Info.plist`
- `lib/config/app_config.dart`
- `lib/config/setting_keys.dart`
- `lib/l10n/intl_ar.arb`
- `lib/l10n/intl_be.arb`
- `lib/l10n/intl_ca.arb`
- `lib/l10n/intl_cs.arb`
- `lib/l10n/intl_de.arb`
- `lib/l10n/intl_en.arb`
- `lib/l10n/intl_eo.arb`
- `lib/l10n/intl_es.arb`
- `lib/l10n/intl_et.arb`
- `lib/l10n/intl_eu.arb`
- `lib/l10n/intl_fa.arb`
- `lib/l10n/intl_fi.arb`
- `lib/l10n/intl_fr.arb`
- `lib/l10n/intl_ga.arb`
- `lib/l10n/intl_gl.arb`
- `lib/l10n/intl_he.arb`
- `lib/l10n/intl_hr.arb`
- `lib/l10n/intl_hu.arb`
- `lib/l10n/intl_id.arb`
- `lib/l10n/intl_it.arb`
- `lib/l10n/intl_ja.arb`
- `lib/l10n/intl_kab.arb`
- `lib/l10n/intl_ko.arb`
- `lib/l10n/intl_lt.arb`
- `lib/l10n/intl_lv.arb`
- `lib/l10n/intl_nb.arb`
- `lib/l10n/intl_nl.arb`
- `lib/l10n/intl_pl.arb`
- `lib/l10n/intl_pt_BR.arb`
- `lib/l10n/intl_pt_PT.arb`
- `lib/l10n/intl_ro.arb`
- `lib/l10n/intl_ru.arb`
- `lib/l10n/intl_sk.arb`
- `lib/l10n/intl_sr.arb`
- `lib/l10n/intl_sv.arb`
- `lib/l10n/intl_ta.arb`
- `lib/l10n/intl_tr.arb`
- `lib/l10n/intl_uk.arb`
- `lib/l10n/intl_uz.arb`
- `lib/l10n/intl_vi.arb`
- `lib/l10n/intl_zh.arb`
- `lib/l10n/intl_zh_Hant.arb`
- `lib/pages/bootstrap/view_model/bootstrap_view_model.dart`
- `lib/pages/chat/sticker_picker_dialog.dart`
- `lib/pages/chat_encryption_settings/chat_encryption_settings_view.dart`
- `lib/pages/chat_list/client_chooser_button.dart`
- `lib/pages/intro/intro_page.dart`
- `lib/pages/settings/settings_view.dart`
- `lib/utils/background_push.dart`
- `lib/utils/client_manager.dart`
- `lib/utils/error_reporter.dart`
- `lib/utils/fluffy_share.dart`
- `lib/utils/platform_infos.dart`
- `lib/utils/show_update_snackbar.dart`
- `lib/utils/sign_in_flows/oidc_login.dart`
- `lib/utils/start_push_foreground_service.dart`
- `lib/widgets/layouts/login_scaffold.dart`
- `lib/widgets/matrix.dart`
- `linux/my_application.cc`
- `macos/Runner.xcodeproj/project.pbxproj`
- `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png`
- `macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png`
- `macos/Runner/Configs/AppInfo.xcconfig`
- `macos/Runner/Info.plist`
- `pubspec.yaml`
- `snap/gui/fluffychat.desktop`
- `snap/gui/fluffychat.png`
- `snap/snapcraft.yaml`
- `test/orda_branding_test.dart`
- `web/favicon.png`
- `web/icons/Icon-16.png`
- `web/icons/Icon-192.png`
- `web/icons/Icon-32.png`
- `web/icons/Icon-48.png`
- `web/icons/Icon-512.png`
- `web/icons/Icon-maskable-192.png`
- `web/icons/Icon-maskable-512.png`
- `web/index.html`
- `web/manifest.json`
- `windows/installer.iss`
- `windows/runner/Runner.rc`
- `windows/runner/main.cpp`
- `windows/runner/resources/app_icon.ico`
