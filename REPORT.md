# Отчёт о проверках

Проверено вручную в Docker Desktop, 22.11.2026:

- `docker compose up -d --build` собрал образ; сервисы app и redis запустились, Redis стал healthy.
- `GET /` вернул счётчик `6`; после `docker compose down` (без `-v`) и повторного `up -d` значение осталось `6`.
- При `docker compose stop redis`: `/healthz` вернул HTTP 200; `/readyz` и `POST /increment` вернули HTTP 503.
- После `docker compose start redis`: `GET /` вернул `6`, следующий `POST /increment` вернул `7`.

Автоматический сценарий `scripts/check.sh` добавлен. Два успешных запуска подряд ещё нужно выполнить и записать здесь результаты; этот пункт не заявляется как проверенный.
