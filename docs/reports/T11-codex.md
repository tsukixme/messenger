# T11 — ребрендинг Tildes

Дата проверки: 2026-10-01. Репозиторий: `tsukixme/messenger`, ветка: `rebrand`.
Исходный commit: `4ad1bcffd63c38ef1e550e3be2c1c83c9704ec21`.

## Сделано

- Название приложения — `Tildes`: Flutter, Android launcher, iOS Runner и Share Extension, web title и PWA manifest. Тексты разрешений iOS также используют Tildes.
- Android `applicationId` и Fastlane package name: `kz.tildes.chat`. Внутренний namespace и Kotlin package оставлены прежними для минимального diff.
- Во всех конфигурациях Runner.xcodeproj: Runner — `kz.tildes.chat`, Share — `kz.tildes.chat.FluffyChat-Share`, Notification Service — `kz.tildes.chat.Notification-Service-Extension`. Разные суффиксы подтверждены пользователем.
- App Group `group.kz.tildes.chat` согласован между тремя entitlement-файлами, Swift-расширением, Dart-хранилищем и ключом шифрования. Обновлена схема возврата ShareMedia и идентификатор iOS Fastlane.
- Единственное место для замены встроенного домена всех трёх платформ: `AppConfig.defaultHomeserver` в `lib/config/app_config.dart`. Пока это заданная заглушка. После замены нужно пересобрать приложения.
- Точное имя ключа JSON/MDM — `defaultHomeserver`; написание `defaultHomeServer` не распознаётся. `presetHomeserver` — отдельная настройка. Существующие явные web/MDM overrides сохранены. Из sample удалено старое значение сервера, чтобы копирование JSON не перекрывало общий default.
- Иконки не менялись. Список файлов для будущей замены и полный список изменённых файлов приведены в PR. Лицензия AGPL-3.0 и упоминания авторов сохранены.

## Вывод проверки

- Использованы Flutter `3.47.4` из `.tool_versions.yaml` и Dart `3.13.3`, Windows, JDK 21.
- `flutter pub get --enforce-lockfile`: exit 0, `pubspec.lock` не изменён.
- Исходный `flutter analyze`: exit 0, `No issues found!`.
- Итоговый `flutter analyze`: exit 0, `No issues found!`; новых ошибок нет.
- `flutter build apk --debug`: exit 0, `Built build/app/outputs/flutter-apk/app-debug.apk`; Gradle assembleDebug — 271,1 с.
- `aapt dump badging` готового APK: package `kz.tildes.chat`, application-label `Tildes`, launchable activity `chat.fluffy.fluffychat.MainActivity`. Размер debug APK — 294 848 606 байт; бинарник не добавлен в Git.
- SHA-256 APK: `4f099fb7179ea0c68a8869df44f5dd3192ad44457676d865edbe5b47dd287c79`.
- `git diff --check`: exit 0. JSON и plist успешно прочитаны; проверены все 9 Bundle ID и единый App Group. Git blobs 107 файлов ресурсов/иконок/лицензии совпадают с исходным commit; существующие SPDX-строки в изменённых исходниках сохранены.
- Независимое ревью обнаружило старый Android Fastlane package name; он исправлен на новый applicationId.

## Проблемы

- Реального Matrix-сервера и домена пока нет. Заглушка не подтверждает доступность сервера, входа или регистрации.
- iOS-сборка и запуск на iPhone не проверены: текущая среда Windows. Нужны macOS/Xcode, собственная Apple Developer Team, профили и регистрация новых App ID/App Group. Настройки команды и Firebase, унаследованные от upstream, не считаются настроенными для Tildes.
- В зависимостях есть предупреждения об устаревании AGP/Kotlin, SDK XML и Java API; обновление toolchain вынесено за рамки минимального ребрендинга.
- Web build и устройство Android не проверялись; проверка PWA здесь ограничена метаданными. Остались upstream URL-схемы, ссылки помощи/поддержки/push и часть локализованных текстов FluffyChat; их массовая замена и настройка собственного push требуют отдельной задачи. Авторские упоминания удалять нельзя.
- Варианты решения: общий Dart-default выбран вместо нового загрузчика JSON для native, чтобы не менять инициализацию FluffyChat. JSON/MDM можно использовать для явного override. Одинаковый Bundle ID для всех iOS targets не использован по уточнению пользователя; расширения имеют отдельные ID. Внутренние имена targets, классов и Android namespace сохранены.

## Что дальше

1. Передать PR архитектору Claude для ревью; merge в этой задаче не выполняется.
2. Когда появится домен, заменить только `AppConfig.defaultHomeserver` и пересобрать клиенты. Проверить Matrix discovery, вход и регистрацию на реальном сервере.
3. Отдельно заменить перечисленные в PR иконки и согласовать остальные тексты/ссылки бренда.
4. Настроить собственные signing/push/Firebase для выпуска. На macOS собрать iOS и проверить Share Extension, зашифрованную БД и Notification Service на устройстве; для Android проверить APK и подготовить подписанный release/AAB.
5. Регистрация по номеру телефона/SMS, серверное развёртывание и распространение через магазины — следующие задачи, не часть T11.
