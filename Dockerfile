FROM python:3.12-slim AS yt-dlp-builder

RUN pip install --no-cache-dir yt-dlp


FROM n8nio/n8n:latest

USER root

COPY --from=yt-dlp-builder /usr/local/bin/yt-dlp /usr/local/bin/yt-dlp
COPY --from=yt-dlp-builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=yt-dlp-builder /usr/local/bin/python3 /usr/local/bin/python3

RUN ln -s /usr/local/bin/python3 /usr/bin/python3 || true

USER node