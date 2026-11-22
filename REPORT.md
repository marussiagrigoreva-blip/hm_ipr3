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

<img width="1010" height="76" alt="image" src="https://github.com/user-attachments/assets/997f882b-d400-4122-a3b7-bfd19813515d" />

docker compose up -d

<img width="996" height="84" alt="image" src="https://github.com/user-attachments/assets/0882d50d-2765-4a8a-954a-08254590d6fb" />


curl.exe http://localhost:8080/

<img width="967" height="38" alt="image" src="https://github.com/user-attachments/assets/c7710193-ab4a-4fde-bc96-df76ab23c4f3" />

docker compose stop redis

<img width="692" height="72" alt="image" src="https://github.com/user-attachments/assets/445bf436-67c1-41a7-8b93-2e1c4c87cf0a" />

curl.exe http://localhost:8080/healthz

<img width="441" height="47" alt="image" src="https://github.com/user-attachments/assets/49f9bc7b-d5d5-4584-85e3-1bc891a211f0" />

curl.exe http://localhost:8080/readyz

<img width="508" height="44" alt="image" src="https://github.com/user-attachments/assets/c1ba1f13-537f-4a60-95ba-b3bca2359bed" />

curl.exe -X POST http://localhost:8080/increment

<img width="692" height="43" alt="image" src="https://github.com/user-attachments/assets/7d23abc2-23df-4309-ad40-b42ae0621ff9" />

При остановленном Redis: /healthz вернул HTTP 200, /readyz и POST /increment — HTTP 503.

docker compose start redis

curl.exe http://localhost:8080/
{"greeting": "Hello from Docker!", "count": 7, "hostname": "b476d558eee9", "storage": "redis"}

curl.exe -X POST http://localhost:8080/increment
{"greeting": "Hello from Docker!", "count": 8, "hostname": "b476d558eee9", "storage": "redis"}

После запуска Redis GET / вернул count: 7, следующий POST /increment — count: 8.


