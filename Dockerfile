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

# Python runtime из Alpine
COPY --from=builder /usr/bin/python3 /usr/bin/python3
COPY --from=builder /usr/lib/libpython3.so* /usr/lib/
COPY --from=builder /usr/lib/python3.*/ /usr/lib/python3.*/

# yt-dlp python package
COPY --from=builder /opt/yt-dlp /opt/yt-dlp

# ffmpeg
COPY --from=builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=builder /usr/lib/libav* /usr/lib/
COPY --from=builder /usr/lib/libsw* /usr/lib/

# wrapper вместо бинарника yt-dlp
RUN echo '#!/bin/sh' > /usr/local/bin/yt-dlp && \
    echo 'PYTHONPATH=/opt/yt-dlp python3 -m yt_dlp "$@"' >> /usr/local/bin/yt-dlp && \
    chmod +x /usr/local/bin/yt-dlp

USER node