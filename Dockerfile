FROM alpine:latest AS builder

RUN apk add --no-cache python3 py3-pip ffmpeg

RUN pip3 install --break-system-packages yt-dlp


FROM n8nio/n8n:latest

USER root

COPY --from=builder /usr/bin/python3 /usr/bin/python3
COPY --from=builder /usr/lib/python3* /usr/lib/
COPY --from=builder /usr/lib/python3.*/site-packages /usr/lib/

COPY --from=builder /usr/bin/yt-dlp /usr/local/bin/yt-dlp
COPY --from=builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg

USER node