const { chromium } = require('@playwright/test');

async function main() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  page.on('console', msg => {
    console.log(`[CONSOLE] [${msg.type()}] ${msg.text()}`);
  });

  page.on('pageerror', err => {
    console.log(`[PAGE ERROR] ${err.toString()}`);
  });

  page.on('requestfailed', request => {
    console.log(`[REQ FAILED] ${request.url()}: ${request.failure()?.errorText}`);
  });

  page.on('response', response => {
    if (response.status() >= 400) {
      console.log(`[HTTP ERROR] ${response.url()}: ${response.status()}`);
    }
  });

  console.log('Navigating to https://primecare-auth.pages.dev/login...');
  try {
    await page.goto('https://primecare-auth.pages.dev/login', { timeout: 15000 });
    console.log('Page loaded. Waiting 10 seconds for runtime initialization...');
    await page.waitForTimeout(10000);
    console.log('Capture complete.');
  } catch (e) {
    console.log(`Navigation error: ${e.message}`);
  } finally {
    await browser.close();
  }
}

main().catch(err => {
  console.error(err);
});
