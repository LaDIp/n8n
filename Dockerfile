FROM alpine:3.24 AS builder

RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg

RUN pip3 install \
    --break-system-packages \
    --no-cache-dir \
    --target=/opt/python-packages \
    yt-dlp


FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache python3 ffmpeg

COPY --from=builder /opt/python-packages /usr/lib/python3.12/site-packages/

RUN echo '#!/bin/sh\npython3 -m yt_dlp "$@"' > /usr/local/bin/yt-dlp && \
    chmod +x /usr/local/bin/yt-dlp

USER node