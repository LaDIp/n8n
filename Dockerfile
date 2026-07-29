FROM alpine:3.24 AS tools

RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg \
    ca-certificates

RUN pip3 install --break-system-packages yt-dlp


FROM n8nio/n8n:latest

USER root

COPY --from=tools /usr/bin/python3 /usr/bin/python3
COPY --from=tools /usr/bin/yt-dlp /usr/bin/yt-dlp

COPY --from=tools /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=tools /usr/bin/ffprobe /usr/bin/ffprobe

# Python runtime libraries
COPY --from=tools /usr/lib /tmp/python-libs

RUN cp -a /tmp/python-libs/* /usr/lib/ 2>/dev/null || true && \
    rm -rf /tmp/python-libs && \
    chmod +x /usr/bin/python3 /usr/bin/yt-dlp

USER node