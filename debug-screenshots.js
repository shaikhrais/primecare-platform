const puppeteer = require('puppeteer');
const TARGET_URL = 'https://primecare-admin.pages.dev/admin';

async function debugFrontend() {
    const browser = await puppeteer.launch({
        headless: "new",
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    
    // Catch all browser logs
    page.on('console', msg => console.log('PAGE LOG:', msg.text()));
    page.on('pageerror', error => console.error('PAGE ERROR:', error.message));

    await page.setRequestInterception(true);
    page.on('request', (req) => {
        const url = req.url();
        if (url.includes('/api/v1/auth/whoami') || url.includes('/api/v1/auth/refresh')) {
            req.respond({
                status: 200,
                contentType: 'application/json',
                body: JSON.stringify({ id: '1', email: 'test@t.com', roles: ['admin'] })
            });
        } else if (url.includes('/api/v1/')) {
            req.respond({ status: 200, contentType: 'application/json', body: '[]' });
        } else {
            req.continue();
        }
    });

    console.log(`Navigating to ${TARGET_URL}...`);
    
    // We navigate to base to set token first
    await page.goto('https://primecare-admin.pages.dev', { waitUntil: 'domcontentloaded' });
    await page.evaluate(() => {
        localStorage.setItem('token', 'mock_jwt_structural_bypass_token');
        localStorage.setItem('user', JSON.stringify({ id: '1', email: 'sys', roles: ['admin'], tenantId: 'core' }));
    });

    await page.goto(TARGET_URL, { waitUntil: 'networkidle0', timeout: 30000 });
    
    // Check if body is empty
    const bodyContent = await page.evaluate(() => document.body.innerHTML);
    const textContent = await page.evaluate(() => document.body.innerText);
    console.log(`Body length: ${bodyContent.length}, Text length: ${textContent.length}`);
    if (bodyContent.length < 500) {
        console.log("Body Snippet:", bodyContent.substring(0, 500));
    }

    await browser.close();
}

debugFrontend().catch(console.error);
