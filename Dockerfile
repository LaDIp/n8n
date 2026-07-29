FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg \
    gcc \
    musl-dev \
    python3-dev

RUN pip3 install \
    --break-system-packages \
    --no-cache-dir \
    yt-dlp

USER node