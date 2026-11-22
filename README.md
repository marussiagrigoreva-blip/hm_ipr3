# Счётчик в Docker

Исходный сервис находится в `app.py`; его код не менялся. Compose запускает приложение и Redis. Снаружи доступен только порт приложения; Redis сохраняет данные в именованном volume с AOF.

## Настройки и запуск

Скопируйте `.env.example` в `.env`, при необходимости измените `GREETING` и `APP_PORT`, затем выполните:

```sh
docker compose up -d --build
curl http://localhost:8080/
curl -X POST http://localhost:8080/increment
docker compose logs
```

Остановка без удаления счётчика: `docker compose down`. Команда `docker compose down -v` удаляет volume с данными.

Контейнер приложения запускается с UID 10001, read-only корневой файловой системой, лимитами 256 MiB и 1 CPU. Оба сервиса имеют healthcheck.

## Автоматическая проверка восстановления

Нужны Docker Compose и `curl`. В Linux/macOS из корня репозитория запустите два раза подряд:

```sh
chmod +x scripts/check.sh
./scripts/check.sh
./scripts/check.sh
```

В Windows запустите команды из Git Bash: `bash scripts/check.sh` два раза. Скрипт создаёт уникальный тестовый Compose-проект, проверяет начальный счётчик, его сохранение после пересоздания app, недоступность Redis и восстановление, создаёт согласованный архив Redis и удаляет только свой проект и volume. Архив по умолчанию создаётся как `redis-backup.tar.gz` в текущей папке.
