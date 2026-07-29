FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache python3
RUN apk add --no-cache py3-pip
RUN apk add --no-cache ffmpeg
RUN pip3 install --break-system-packages -U yt-dlp

USER node