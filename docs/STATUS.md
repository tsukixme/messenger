# Статус Tildes

Обновлено: 2026-10-02. Статус «готово» присваивается только по проверенным
результатам. Правила команды: [COORDINATION.md](COORDINATION.md).

| Номер | Исполнитель | Статус | Отчёт |
|---|---|---|---|
| T11 | Codex; ревью Claude по сообщению владельца | Готово, PR #1 слит; merge проверен через GitHub | [T11-codex.md](reports/T11-codex.md) |
| S1 | Владелец: установка; Codex: инструкции/приёмка | Принято: Ubuntu/Docker работают; SSH по проектному ключу со строгим known_hosts проверен. ВМ включена 2026-10-02 | [S1](reports/S1-codex.md), [проверки SSH/стека S3](https://github.com/tsukixme/messenger-server/blob/main/docs/reports/S3-codex.md) |
| [T22](tasks/T22-Claude.md) | Claude | Возвращено на доработку; основные риски подтверждены локально, Flutter-аудит/план неполны | [Ответ](reports/T22-Claude.md), [проверка Codex](reports/T22-codex-review.md) |
| [T23](tasks/T23-Gemini-2.md) | Antigravity 2.0 / Gemini 2 | Возвращено на доработку: источники/условия, API и чек-листы требуют исправлений | [Ответ](reports/T23-Gemini-2.md), [проверка Codex](reports/T23-codex-review.md) |
| [T24](tasks/T24-Gemini-1.md) | Antigravity IDE / Gemini 1 | Возвращено на доработку после самостоятельной проверки текста; ВМ не передана | [Ответ](reports/T24-Gemini-1.md), [проверка Codex](reports/T24-codex-review.md) |
| [T25](tasks/T25-Gemini-1.md) | Antigravity IDE / Gemini 1 | Исправления памятки подготовлены, ожидают передачи владельцем | Отчёт не поступил |
| [T26](tasks/T26-Claude.md) | Claude | Завершение Flutter-аудита/отчёта; серверный пакет уже получен, повторная разработка auth не нужна | Исправленный отчёт не поступил |
| [T27](tasks/T27-Gemini-2.md) | Antigravity 2.0 / Gemini 2 | Исправления инструкций и полных чек-листов подготовлены; ожидает передачи владельцем | Отчёт не поступил |
| S2 | Codex | Принято: 13/13 pytest; Docker build — exit 0, отказ без секрета — exit 1 за 0,61 с. PR #1 сервера слит; merge независимо проверен | [S2-codex.md](https://github.com/tsukixme/messenger-server/blob/main/docs/reports/S2-codex.md) |
| S3 | Codex; владелец вводит секреты и создаёт аккаунты | Принято в последнем согласованном объёме: стек работает, admin/demo1–demo4 активны, внешний login и обмен demo1 → demo2 проверены; итоговая копия создана. Скрипты PR #2 ждут ревью | [S3-codex.md](https://github.com/tsukixme/messenger-server/blob/main/docs/reports/S3-codex.md) |
| S4 | Codex | Android release arm64 и web CI успешны; APK подпись/digest проверены. Временный триггер удалён. Публикация web и телефоны ещё не проверены; PR ждут «Claude одобрил» | [S4-codex.md](https://github.com/tsukixme/messenger/blob/ci-builds/docs/reports/S4-codex.md), [CI](https://github.com/tsukixme/messenger/actions/runs/36970952993) |
| [T28](tasks/T28-Claude.md) | Claude; перепроверка Codex | Принято с уточнениями. Отдельный REUSE PR #3: Check licenses / 4 теста прошли; серверный PR #2: 7 тестов прошли. Слияния не выполнены | [Ответ](reports/T28-Claude.md), [проверка](reports/T28-codex-review.md), [сервер](https://github.com/tsukixme/messenger-server/blob/main/docs/reports/T28-codex.md) |
| S5 | Codex; Claude по отдельным карточкам | Явно отложен владельцем вместе с WhatsApp; файлы из набора не применялись | — |
| S6 | Codex | Не начат; настоящий домен ещё не сообщён | — |

Gemini 1 не работает с ВМ: передачи ресурса не было. Codex управляет ВМ
только через проверенный SSH; владелец сам вводит секреты интерактивно.
Claude и два Antigravity получают карточки через владельца;
запись в репозитории остаётся у Codex. Ответы T22/T23/T24 получены,
самостоятельно проверены и возвращены на доработку через T26/T27/T25.
Владелец согласовал DEV_MODE=false по умолчанию и отказ запуска без
WA_APP_SECRET вне тестового режима. Затем предоставил готовый пакет
auth-update.zip и поручил его применение Codex; дополнительных изменений
сверх README не разрешено. Серверный PR auth-hardening слит; код пакета
не редактировался. Затем выполнены S3: полный compose up, публичные API,
аккаунты, проверка обмена и копий. Реальный WhatsApp отложен; auth работает
со случайным секретом, DEV_MODE=false. По новой инструкции S4 включает
облачные сборки и web из tildes-next.zip, S5 не выполняется. S4 ещё не принят
полностью: артефакты Android/web готовы, публикация web и тесты устройств
не выполнены; слияние кодовых PR требует
явного сообщения владельца «Claude одобрил».
Еженедельное обновление включено в Codex; обновление по просьбе владельца
также сохраняется. Непроверенные отчёты автоматически не принимаются.

2026-10-02: T28 получен и принят с уточнениями ([проверка](reports/T28-codex-review.md)). Владелец выбрал B и временный release-ключ/arm64. Android/web успешно собраны на `1c4e507`; commit `e2b033254` восстановил push `main`, сохранив те же jobs. REUSE — [PR #3 приложения](https://github.com/tsukixme/messenger/pull/3), сборки — [PR #2 приложения](https://github.com/tsukixme/messenger/pull/2), пароль/место — [PR #2 сервера](https://github.com/tsukixme/messenger-server/pull/2). Общие проверки PR сборок пока требуют интеграции REUSE; runtime скрипты ВМ не заменялись. Merge ожидает отдельного «Claude одобрил».
