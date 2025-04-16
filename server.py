from flask import Flask, jsonify
import json
from pathlib import Path

app = Flask(__name__)

@app.route('/')
def home():
    scraped_file = Path('/scraper/scraped_data.json')
    if scraped_file.exists():
        try:
            data = json.loads(scraped_file.read_text(encoding='utf-8'))
        except json.JSONDecodeError as e:
            data = {"error": f"Failed to decode JSON: {e}"}
    else:
        data = {"error": "scraped_data.json not found. Please run the scraper."}
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)