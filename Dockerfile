FROM alpine:latest AS downloader

RUN apk add --no-cache curl

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    -o /yt-dlp \
    && chmod +x /yt-dlp


FROM n8nio/n8n:latest

USER root

COPY --from=downloader /yt-dlp /usr/local/bin/yt-dlp

USER node