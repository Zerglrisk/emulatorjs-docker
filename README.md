# EmulatorJS Docker

웹 브라우저에서 레트로 게임을 플레이할 수 있는 EmulatorJS 컨테이너

[![Docker Build](https://github.com/zerglrisk/emulatorjs-docker/actions/workflows/build.yml/badge.svg)](https://github.com/zerglrisk/emulatorjs-docker/actions/workflows/build.yml)

## 사용법
```bash
docker run -d \
  --name emulatorjs \
  -p 8080:80 \
  -v /your/roms:/usr/share/nginx/html/roms \
  zerglrisk/emulatorjs
```

## Docker Compose
```yaml
services:
  emulatorjs:
    image: zerglrisk/emulatorjs:latest
    ports:
      - "8080:80"
    volumes:
      - /mnt/main-pool/media/roms:/usr/share/nginx/html/roms:ro
    restart: unless-stopped
```

## ROM 디렉토리 구조
```
roms/
├── nes/
├── snes/
├── gba/
└── psx/
```

## 지원 시스템

NES, SNES, GB, GBC, GBA, N64, PSX, Sega Genesis 등

## 자동 업데이트

EmulatorJS 새 릴리즈가 나오면 매일 자동으로 감지하여 빌드합니다.

## TrueNAS 연동

RomM과 동일한 ROM 디렉토리 공유 가능