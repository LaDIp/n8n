FROM n8nio/n8n:latest

USER root

# Устанавливаем yt-dlp и зависимости
RUN wget -O /usr/local/bin/yt-dlp \
        https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && \
    chmod +x /usr/local/bin/yt-dlp

USER node
