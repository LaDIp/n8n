FROM node:22-alpine

RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg && \
    pip3 install --break-system-packages yt-dlp

RUN npm install -g n8n

USER node

EXPOSE 5678

CMD ["n8n"]