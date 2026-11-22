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

APP_PORT=18081 bash scripts/check.sh
<img width="989" height="125" alt="image" src="https://github.com/user-attachments/assets/8433b3d1-10fe-47c2-821f-1ebdbe72f719" />

APP_PORT=18081 bash scripts/check.sh
<img width="521" height="131" alt="image" src="https://github.com/user-attachments/assets/24b63069-ac17-47f6-81cf-18cef1732e20" />


отчет для отдельного хранилища
docker compose down
docker compose up -d
curl.exe http://localhost:8080/
<img width="1010" height="76" alt="image" src="https://github.com/user-attachments/assets/997f882b-d400-4122-a3b7-bfd19813515d" />
<img width="996" height="84" alt="image" src="https://github.com/user-attachments/assets/0882d50d-2765-4a8a-954a-08254590d6fb" />
<img width="967" height="38" alt="image" src="https://github.com/user-attachments/assets/c7710193-ab4a-4fde-bc96-df76ab23c4f3" />


