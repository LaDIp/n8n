FROM alpine:3.24 AS builder

RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg

RUN pip3 install \
    --break-system-packages \
    --target=/opt/yt-dlp \
    yt-dlp


FROM n8nio/n8n:latest

USER root

# Python runtime
COPY --from=builder /usr/bin/python3 /usr/bin/python3
COPY --from=builder /usr/lib/libpython3.14.so.1.0 /usr/lib/
COPY --from=builder /usr/lib/python3.14 /usr/lib/python3.14

# Python зависимости yt-dlp
COPY --from=builder /opt/yt-dlp /opt/yt-dlp

# ffmpeg + ffprobe
COPY --from=builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=builder /usr/bin/ffprobe /usr/local/bin/ffprobe

# Библиотеки ffmpeg
COPY --from=builder /usr/lib/libav* /usr/lib/
COPY --from=builder /usr/lib/libsw* /usr/lib/
COPY --from=builder /usr/lib/libpostproc* /usr/lib/

# Обертка yt-dlp
RUN printf '#!/bin/sh\nPYTHONPATH=/opt/yt-dlp python3 -m yt_dlp "$@"\n' \
    > /usr/local/bin/yt-dlp && \
    chmod +x /usr/local/bin/yt-dlp

USER node