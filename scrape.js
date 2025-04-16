const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
  const url = process.env.SCRAPE_URL || process.argv[2];
  if (!url) {
    console.error('Error: Please provide a URL to scrape using SCRAPE_URL env variable or as a command-line argument.');
    process.exit(1);
  }

  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-gpu'],
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/google-chrome'
  });
  const page = await browser.newPage();
  await page.goto(url, { waitUntil: 'networkidle0', timeout: 60000 });

  const data = await page.evaluate(() => {
    return {
      title: document.title,
      heading: document.querySelector('h1') ? document.querySelector('h1').innerText : 'No h1 found'
    };
  });

  await browser.close();

  fs.writeFileSync('/scraper/scraped_data.json', JSON.stringify(data, null, 2));
  console.log('Scraping completed. Data saved to scraped_data.json');
})();