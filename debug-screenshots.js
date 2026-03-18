const puppeteer = require('puppeteer');
const TARGET_URL = 'https://primecare-admin.pages.dev/admin';

async function debugFrontend() {
    const browser = await puppeteer.launch({
        headless: "new",
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--window-size=1920,1080']
    });

    const page = await browser.newPage();
    
    // Catch all browser logs
    page.on('console', msg => console.log('PAGE LOG:', msg.text()));
    page.on('pageerror', error => console.error('PAGE ERROR:', error.message));
    page.on('response', response => {
        if (!response.ok()) {
            console.log(`PAGE NETWORK ERROR: ${response.status()} ${response.url()}`);
        }
    });

    console.log(`Navigating to ${TARGET_URL}...`);
    await page.goto('https://primecare-admin.pages.dev', { waitUntil: 'domcontentloaded' });
    
    await page.evaluate(() => {
        localStorage.setItem('token', 'mock_jwt_structural_bypass_token');
        localStorage.setItem('user', JSON.stringify({ 
            id: 'sys-admin-999', 
            email: 'system@primecare.com', 
            roles: ['admin'], 
            tenantId: 'core-tenant' 
        }));
    });

    await page.goto(TARGET_URL, { waitUntil: 'networkidle0', timeout: 30000 });
    
    // Check if body is empty
    const bodyContent = await page.evaluate(() => document.body.innerHTML);
    console.log(`Body length: ${bodyContent.length}`);
    if (bodyContent.length < 500) {
        console.log("Body Snippet:", bodyContent.substring(0, 500));
    }

    await browser.close();
}

debugFrontend().catch(console.error);
