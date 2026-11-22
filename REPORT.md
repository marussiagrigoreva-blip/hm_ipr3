# Отчёт о проверках

Проверено вручную в Docker Desktop, 22.11.2026:

- `docker compose up -d --build` собрал образ; сервисы app и redis запустились, Redis стал healthy.
- `GET /` вернул счётчик `6`; после `docker compose down` (без `-v`) и повторного `up -d` значение осталось `6`.
- При `docker compose stop redis`: `/healthz` вернул HTTP 200; `/readyz` и `POST /increment` вернули HTTP 503.
- После `docker compose start redis`: `GET /` вернул `6`, следующий `POST /increment` вернул `7`.

Автоматический сценарий `scripts/check.sh` запущен два раза подряд из WSL с Docker Desktop; оба запуска завершились строкой `PASS: test containers, network, and volume removed`.

Для каждого запуска:
- 5 POST-запросов дали счётчик 5;
- пересоздание контейнера app сохранило счётчик 5;
- при остановленном Redis `/healthz` вернул 200, `/readyz` и POST вернули 503;
- после запуска Redis GET сохранил 5, следующий POST вернул 6;
- создан архив `redis-backup.tar.gz`;
- тестовые контейнеры, сеть и volume удалены.

Команда для обоих запусков: `APP_PORT=18081 bash scripts/check.sh`.
