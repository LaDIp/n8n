FROM n8nio/n8n:latest

USER root

RUN npm install -g npm@latest \
    && apk add --no-cache python3 py3-pip ffmpeg \
    && pip3 install --break-system-packages yt-dlp

USER node