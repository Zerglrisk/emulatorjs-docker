FROM node:18-alpine AS builder

ARG EMULATORJS_VERSION=main

WORKDIR /build

RUN apk add --no-cache git p7zip sed && \
    echo "Building EmulatorJS version: ${EMULATORJS_VERSION}" && \
    git clone --depth 1 --branch ${EMULATORJS_VERSION} https://github.com/EmulatorJS/EmulatorJS.git . && \
    sed -i 's/process\.stdout\.clearLine();//g' build.js && \
    sed -i 's/process\.stdout\.cursorTo(0);//g' build.js && \
    npm install && \
    npm install @emulatorjs/cores && \
    npm run build || (echo "Build failed, trying alternative..." && mkdir -p dist && cp -r data dist/)

FROM nginx:alpine

LABEL maintainer="zerglrisk"
LABEL description="EmulatorJS - 웹 브라우저 기반 레트로 게임 에뮬레이터 (Self-built)"

COPY --from=builder /build/dist /usr/share/nginx/html

RUN mkdir -p /usr/share/nginx/html/roms

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]