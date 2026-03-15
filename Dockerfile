FROM nginx:alpine

LABEL maintainer="zerglrisk"
LABEL description="EmulatorJS - 웹 브라우저 기반 레트로 게임 에뮬레이터"

# EmulatorJS 다운로드 및 설정
RUN apk add --no-cache git && \
    git clone --depth 1 https://github.com/EmulatorJS/EmulatorJS.git /tmp/emu && \
    mkdir -p /usr/share/nginx/html && \
    mv /tmp/emu/* /usr/share/nginx/html/ && \
    mkdir -p /usr/share/nginx/html/roms && \
    rm -rf /tmp/emu && \
    apk del git

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]