FROM nginx:alpine

LABEL maintainer="zerglrisk"
LABEL description="EmulatorJS - 웹 브라우저 기반 레트로 게임 에뮬레이터"

ARG EMULATORJS_VERSION=main

RUN apk add --no-cache git && \
    echo "Cloning EmulatorJS version: ${EMULATORJS_VERSION}" && \
    git clone --depth 1 --branch ${EMULATORJS_VERSION} https://github.com/EmulatorJS/EmulatorJS.git /tmp/emu && \
    mkdir -p /usr/share/nginx/html && \
    mv /tmp/emu/* /usr/share/nginx/html/ && \
    mkdir -p /usr/share/nginx/html/roms && \
    rm -rf /tmp/emu && \
    apk del git

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]