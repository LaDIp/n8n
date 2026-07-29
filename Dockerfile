FROM python:3.12-alpine AS yt-dlp

RUN pip install --no-cache-dir yt-dlp


FROM n8nio/n8n:latest

USER root

COPY --from=yt-dlp /usr/local/bin/yt-dlp /usr/local/bin/yt-dlp
COPY --from=yt-dlp /usr/local/lib/python3.12 /usr/local/lib/python3.12

USER node