# DevOps Multi-Stage Scraper and Server

This project demonstrates a multi-stage Docker build that uses:

- **Node.js** with **Puppeteer** to scrape a user-specified URL.
- **Python Flask** to host the scraped content over HTTP.

# DevOps Scraper

This project is a two-stage Dockerized web scraper application:

- **Stage 1**: Scrapes data from a specified URL using Node.js and Puppeteer.
- **Stage 2**: Hosts the scraped data through a simple Python Flask API.


## Project Structure

- `scrape.js` – Node.js script that uses Puppeteer to navigate to a URL, extract data, and store it as JSON.
- `package.json` – Contains Node.js dependencies.
- `server.py` – Python Flask app that serves the scraped data.
- `requirements.txt` – Lists Python dependencies.
- `Dockerfile` – Multi-stage Dockerfile for building the application.
- `README.md` – Documentation for building and running the container.

## Building the Docker Image

From the project root directory, run:
```bash
docker build --build-arg SCRAPE_URL=https://example.com -t devops-scraper .
