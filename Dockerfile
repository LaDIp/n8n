FROM n8nio/n8n:latest

USER root

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/download/2026.07.04/yt-dlp_linux \
    -o /usr/local/bin/yt-dlp \
    && chmod +x /usr/local/bin/yt-dlp

USER node