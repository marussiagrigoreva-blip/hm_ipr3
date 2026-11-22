# Отчёт о проверках

Проверено вручную в Docker Desktop, 22.11.2026:

- `docker compose up -d --build` собрал образ; сервисы app и redis запустились, Redis стал healthy.
- `GET /` вернул счётчик `6`; после `docker compose down` (без `-v`) и повторного `up -d` значение осталось `6`.
- При `docker compose stop redis`: `/healthz` вернул HTTP 200; `/readyz` и `POST /increment` вернули HTTP 503.
- После `docker compose start redis`: `GET /` вернул `6`, следующий `POST /increment` вернул `7`.

Автоматический сценарий `scripts/check.sh` добавлен. Два успешных запуска подряд ещё нужно выполнить и записать здесь результаты; этот пункт не заявляется как проверенный.

mariia_grigoreva@LAPTOP-M5PK6OK9:/mnt/c/Users/bobrd/Documents/Codex/2026-11-18/skip-to-content-navigation-menu-nikfilk20[+] Building 4.6s (12/12) FINISHED
 => [internal] load local bake definitions                                                                         0.0s
 => => reading from stdin 648B                                                                                     0.0s0
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 374B                                                                               0.1s
 => [internal] load metadata for docker.io/library/python:3.13-slim                                                1.9s0
 => [internal] load .dockerignore                                                                                  0.1s
 => => transferring context: 100B                                                                                  0.1s
 => [1/5] FROM docker.io/library/python:3.13-slim@sha256:e48f59cdba69a3cbd9ed2cf0f348d90d45a8d350d98134cf1070bc10  0.1s
 => => resolve docker.io/library/python:3.13-slim@sha256:e48f59cdba69a3cbd9ed2cf0f348d90d45a8d350d98134cf1070bc10  0.0s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 63B                                                                                   0.1s
 => CACHED [2/5] WORKDIR /app                                                                                      0.0s
 => CACHED [3/5] COPY requirements.txt .                                                                           0.0s0
 => CACHED [4/5] RUN pip install --no-cache-dir -r requirements.txt     && groupadd --gid 10001 app && useradd --  0.0s
 => CACHED [5/5] COPY --chown=10001:10001 app.py .                                                                 0.0s
 => exporting to image                                                                                             0.3s
 => => exporting layers                                                                                            0.0s
 => => exporting manifest sha256:44e24a238847625a8ec2d0a71176d150ad3d0f3f4a270f9cd9f6a48528e77aa8                  0.1s
 => => exporting config sha256:ebaca8f56e9913d6ea9ea897a834b1485653999448e4bf07e2af15aca23ddad5                    0.0s
 => => exporting attestation manifest sha256:901161a6ba51cbe70499ef68b16d4c6eef80f1657b4338274650fbf6cd0c5292      0.0s
 => => exporting manifest list sha256:a6a062d20f299930f2570bdd302a4a44cc261c97db2db09089dc88ec1e40112c             0.0s
 => => naming to docker.io/library/dhwcheck17953595133647-app:latest                                               0.0s
 => => unpacking to docker.io/library/dhwcheck17953595133647-app:latest                                            0.0s
 => resolving provenance for metadata file                                                                         0.0s
[+] up 5/5
 ✔ Image dhwcheck17953595133647-app         Built                                                                   5.1s
 ✔ Network dhwcheck17953595133647_default   Created                                                                 0.2s
 ✔ Volume dhwcheck17953595133647_redis_data Created                                                                 0.1s
 ✔ Container dhwcheck17953595133647-redis-1 Healthy                                                                 7.2s
 ✔ Container dhwcheck17953595133647-app-1   Started                                                                 7.4s
STEP: fresh counter and N increments
PASS: 5 POST requests produced count 5
STEP: recreate app container
[+] up 1/1
 ✔ Container dhwcheck17953595133647-app-1 Started                                                                   4.8s
PASS: app recreation preserved count 5
STEP: Redis outage; waiting up to 30 seconds for expected HTTP responses
[+] stop 1/1
 ✔ Container dhwcheck17953595133647-redis-1 Stopped                                                                 0.5s
Checking that app HTTP server remains available...
Checking that Redis readiness reports unavailable...
Checking that increment returns HTTP 503...
PASS: healthz=200, readyz=503, increment=503 during outage
STEP: Redis recovery
[+] start 1/1
 ✔ Container dhwcheck17953595133647-redis-1 Started                                                                 0.5s
PASS: recovery kept 5; next increment produced 6
STEP: consistent Redis backup
[+] stop 2/2
 ✔ Container dhwcheck17953595133647-app-1   Stopped                                                                 3.3s
 ✔ Container dhwcheck17953595133647-redis-1 Stopped                                                                 0.4s
PASS: consistent backup created at /mnt/c/Users/bobrd/Documents/Codex/2026-11-18/skip-to-content-navigation-menu-nikfilk2030/redis-backup.tar.gz
STEP: cleanup
[+] down 4/4
 ✔ Container dhwcheck17953595133647-app-1   Removed                                                                 0.1s
 ✔ Container dhwcheck17953595133647-redis-1 Removed                                                                 0.3s
 ✔ Volume dhwcheck17953595133647_redis_data Removed                                                                 0.1s
 ✔ Network dhwcheck17953595133647_default   Removed                                                                 0.3s
PASS: test containers, network, and volume removed
mariia_grigoreva@LAPTOP-M5PK6OK9:/mnt/c/Users/bobrd/Documents/Codex/2026-11-18/skip-to-content-navigation-menu-nikfilk20[+] Building 4.4s (12/12) FINISHED
 => [internal] load local bake definitions                                                                         0.0s
 => => reading from stdin 648B                                                                                     0.0s
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 374B                                                                               0.0s
 => [internal] load metadata for docker.io/library/python:3.13-slim                                                2.5s
 => [internal] load .dockerignore                                                                                  0.1s
 => => transferring context: 100B                                                                                  0.1s
 => [1/5] FROM docker.io/library/python:3.13-slim@sha256:e48f59cdba69a3cbd9ed2cf0f348d90d45a8d350d98134cf1070bc10  0.1s
 => => resolve docker.io/library/python:3.13-slim@sha256:e48f59cdba69a3cbd9ed2cf0f348d90d45a8d350d98134cf1070bc10  0.1s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 63B                                                                                   0.1s
 => CACHED [2/5] WORKDIR /app                                                                                      0.0s
 => CACHED [3/5] COPY requirements.txt .                                                                           0.0s
 => CACHED [4/5] RUN pip install --no-cache-dir -r requirements.txt     && groupadd --gid 10001 app && useradd --  0.0s
 => CACHED [5/5] COPY --chown=10001:10001 app.py .                                                                 0.0s
 => exporting to image                                                                                             0.2s
 => => exporting layers                                                                                            0.0s
 => => exporting manifest sha256:d3cd8026e1a204c9752e3cec94042fe3094a9dda622d99c601878659587b60fe                  0.0s
 => => exporting config sha256:ad220b092917180393dc02d0eb75478c5891490229e1333aa3a2250b27bd1c96                    0.0s
 => => exporting attestation manifest sha256:1bb63926fdcc5224be93890b20e2ebd0f4ab7de0245fc310d20763e8161214ba      0.0s
 => => exporting manifest list sha256:9866074ce3dd7d1a2c95695df852550d95f310ff570ca5f3ad0532e47c6858a6             0.0s
 => => naming to docker.io/library/dhwcheck17953596024006-app:latest                                               0.0s
 => => unpacking to docker.io/library/dhwcheck17953596024006-app:latest                                            0.0s
 => resolving provenance for metadata file                                                                         0.0s
[+] up 5/5
 ✔ Image dhwcheck17953596024006-app         Built                                                                   4.7s
 ✔ Network dhwcheck17953596024006_default   Created                                                                 0.2s
 ✔ Volume dhwcheck17953596024006_redis_data Created                                                                 0.1s
 ✔ Container dhwcheck17953596024006-redis-1 Healthy                                                                 6.4s
 ✔ Container dhwcheck17953596024006-app-1   Started                                                                 6.7s
[+] up 1/1
 ✔ Container dhwcheck17953596024006-app-1 Started                                                                   4.4s
PASS: app recreation preserved count 5
STEP: Redis outage; waiting up to 30 seconds for expected HTTP responses
[+] stop 1/1
 ✔ Container dhwcheck17953596024006-redis-1 Stopped                                                                 0.3s
Checking that app HTTP server remains available...
Checking that Redis readiness reports unavailable...
Checking that increment returns HTTP 503...
PASS: healthz=200, readyz=503, increment=503 during outage
STEP: Redis recovery
[+] start 1/1
 ✔ Container dhwcheck17953596024006-redis-1 Started                                                                 0.3s
PASS: recovery kept 5; next increment produced 6
STEP: consistent Redis backup
[+] stop 2/2
 ✔ Container dhwcheck17953596024006-app-1   Stopped                                                                 3.3s
 ✔ Container dhwcheck17953596024006-redis-1 Stopped                                                                 0.3s
PASS: consistent backup created at /mnt/c/Users/bobrd/Documents/Codex/2026-11-18/skip-to-content-navigation-menu-nikfilk2030/redis-backup.tar.gz
STEP: cleanup
[+] down 4/4
 ✔ Container dhwcheck17953596024006-app-1   Removed                                                                 0.1s
 ✔ Container dhwcheck17953596024006-redis-1 Removed                                                                 0.2s
 ✔ Volume dhwcheck17953596024006_redis_data Removed                                                                 0.0s
 ✔ Network dhwcheck17953596024006_default   Removed                                                                 0.3s
PASS: test containers, network, and volume removed
