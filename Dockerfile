FROM emscripten/emsdk:latest AS core-builder

WORKDIR /build

RUN git clone --depth 1 https://github.com/libretro/libretro-super.git && \
    cd libretro-super && \
    ./libretro-fetch.sh && \
    ./libretro-build-emscripten.sh

FROM alpine:latest AS emulator-builder

ARG EMULATORJS_VERSION=main

WORKDIR /build

RUN apk add --no-cache git && \
    echo "Downloading EmulatorJS version: ${EMULATORJS_VERSION}" && \
    git clone --depth 1 --branch ${EMULATORJS_VERSION} https://github.com/EmulatorJS/EmulatorJS.git . && \
    rm -rf .git .github

FROM nginx:alpine

LABEL maintainer="zerglrisk"
LABEL description="EmulatorJS"

COPY --from=emulator-builder /build /usr/share/nginx/html

COPY --from=core-builder /build/libretro-super/dist/emscripten /usr/share/nginx/html/data/cores

RUN mkdir -p /usr/share/nginx/html/roms

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]