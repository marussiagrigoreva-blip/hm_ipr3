Настройки
Перед запуском можно создать файл .env на основе примера:

Shell
cp .env.example .env

Переменные окружения:
Переменная 
Описание 
Значение по умолчанию
GREETING: Приветствие приложения Hello from Docker!
APP_PORT: Порт приложения на компьютере 8080
Запуск
Сборка образа и запуск контейнеров:

docker compose up -d --build

Проверка состояния сервисов:

docker compose ps

Просмотр логов приложения:

docker compose logs app

Приложение доступно по адресу:

http://localhost:8080

API
Метод Адрес Описание
GET / Получить приветствие и текущее значение счётчика
POST /increment Увеличить счётчик
GET /healthz Проверить, что приложение работает
GET /readyz Проверить готовность приложения и доступность хранилища
Примеры запросов:

curl http://localhost:8080/
curl -X POST http://localhost:8080/increment
curl http://localhost:8080/healthz
curl http://localhost:8080/readyz

Хранение данных
Приложение использует Redis (STORAGE=redis).
Redis сохраняет данные в именованный Docker volume redis_data, подключённый к /data. Включено сохранение данных Redis на диск.
После остановки и повторного запуска Compose данные счётчика сохраняются:

Shell
docker compose down
docker compose up -d
Проверить сохранённое значение:

curl http://localhost:8080/
Важно: для проверки сохранения данных не использовать docker compose down -v, так как эта команда удаляет именованные volumes.
Проверка восстановления Redis

Остановить Redis:

docker compose stop redis

Проверить состояние приложения:

curl -i http://localhost:8080/healthz
curl -i http://localhost:8080/readyz
curl -i -X POST http://localhost:8080/increment

Запустить Redis обратно:

docker compose start redis

После восстановления Redis приложение должно снова обрабатывать запросы без ручного перезапуска.

Ограничения приложения
Для контейнера приложения настроены:
непривилегированный пользователь с UID 10001;
файловая система только для чтения;
ограничение памяти — 256 MiB;
ограничение CPU — 1.
Автоматическая проверка
Запуск проверки:

./scripts/check.sh
Скрипт проверяет работу счётчика, сохранение данных, восстановление после остановки Redis и создание резервной копии.
Остановка

docker compose down
Команда останавливает и удаляет контейнеры, но сохраняет именованный volume с данными Redis.
