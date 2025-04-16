FROM node:18-slim AS scraper
WORKDIR /app
COPY scrape.js package.json ./
RUN npm install

FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY server.py requirements.txt ./
RUN pip install -r requirements.txt gunicorn
COPY --from=scraper /app /scraper

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome

CMD ["/bin/sh", "-c", "node /scraper/scrape.js && gunicorn --bind 0.0.0.0:5000 server:app"]