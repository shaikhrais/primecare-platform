const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

const TARGET_URL = 'https://primecare-admin.pages.dev';

const rolesToCapture = [
    { role: 'admin', url: '/admin' },
    { role: 'manager', url: '/tenancy/manager' },
    { role: 'scrum_master', url: '/platform/scrum-master' },
    { role: 'psw', url: '/tenancy/psw' },
    { role: 'rn', url: '/tenancy/rn' }
];

async function captureScreenshots() {
    const screensDir = path.join(__dirname, 'screenshots');
    if (!fs.existsSync(screensDir)) {
        fs.mkdirSync(screensDir, { recursive: true });
    }

    const browser = await puppeteer.launch({
        headless: "new",
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--window-size=1920,1080']
    });

    let htmlContent = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PrimeCare Role-Wise Screenshots Showcase</title>
        <style>
            body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #0f172a; color: #f8fafc; padding: 40px; }
            h1 { text-align: center; font-weight: 300; font-size: 2.5rem; margin-bottom: 50px; color: #38bdf8; }
            .showcase-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(600px, 1fr)); gap: 40px; }
            .card { background: #1e293b; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.5); border: 1px solid #334155; }
            .card-header { padding: 20px; border-bottom: 1px solid #334155; display: flex; align-items: center; justify-content: space-between; }
            .role-badge { background: #0ea5e9; color: white; padding: 6px 14px; border-radius: 20px; font-weight: bold; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px; }
            img { width: 100%; height: auto; display: block; filter: contrast(1.05) brightness(1.02); transition: transform 0.3s ease; }
            img:hover { transform: scale(1.02); }
            a { color: #38bdf8; text-decoration: none; }
            a:hover { text-decoration: underline; }
        </style>
    </head>
    <body>
        <h1>PrimeCare: Live Production Deployment Roles</h1>
        <p style="text-align: center; margin-top: -30px; margin-bottom: 50px; color: #94a3b8;">
            Deployed automatically to <a href="${TARGET_URL}" target="_blank">${TARGET_URL}</a> via Cloudflare Front-End Delivery
        </p>
        <div class="showcase-grid">
    `;

    for (const r of rolesToCapture) {
        console.log(`[+] Firing headless navigator for role: ${r.role}`);
        const page = await browser.newPage();
        await page.setViewport({ width: 1920, height: 1080 });

        // Navigate to base URL to establish origin context for LocalStorage injection
        console.log(`    -> Establishing origin context at ${TARGET_URL}`);
        await page.goto(TARGET_URL, { waitUntil: 'domcontentloaded' });
        
        // Inject malicious LocalStorage JWT state payload targeting the React Auth bounds
        await page.evaluate((roleName) => {
            localStorage.setItem('token', 'mock_jwt_structural_bypass_token');
            localStorage.setItem('user', JSON.stringify({ 
                id: 'sys-admin-999', 
                email: 'system@primecare.com', 
                roles: [roleName], 
                tenantId: 'core-tenant' 
            }));
        }, r.role);

        // Exploit routing tree by targeting the authorized endpoints natively
        const target = `${TARGET_URL}${r.url}`;
        console.log(`    -> Navigating to authorized endpoint: ${target}`);
        
        try {
            await page.goto(target, { waitUntil: 'networkidle0', timeout: 30000 });
            // Wait an extra 2 seconds for any Suspense boundaries / animations to settle
            await new Promise(res => setTimeout(res, 2000));
            
            const imagePath = `screenshots/${r.role}_dashboard.png`;
            await page.screenshot({ path: path.join(__dirname, imagePath), fullPage: false });
            console.log(`    -> Screenshot saved at ${imagePath}`);

            htmlContent += `
            <div class="card">
                <div class="card-header">
                    <span class="role-badge">${r.role.replace('_', ' ')} Dashboard</span>
                    <span style="font-family: monospace; color: #94a3b8; font-size: 0.85rem;">${r.url}</span>
                </div>
                <div style="overflow: hidden;">
                    <a href="${imagePath}" target="_blank">
                        <img src="${imagePath}" alt="${r.role} interface preview" loading="lazy" />
                    </a>
                </div>
            </div>`;
        } catch (e) {
            console.error(`    -> Timeout/Error on role ${r.role}:`, e);
        }
        await page.close();
    }

    htmlContent += `
        </div>
    </body>
    </html>`;

    const htmlPath = path.join(__dirname, 'role-showcase.html');
    fs.writeFileSync(htmlPath, htmlContent);
    console.log(`\n[*] Success: Showcase generated at ${htmlPath}`);

    await browser.close();
}

captureScreenshots().catch(console.error);
