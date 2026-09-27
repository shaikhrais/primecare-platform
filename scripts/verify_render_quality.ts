// Governance - Category: service | Purpose: E2E Live Render Quality & DOM Integrity Verification Engine
import { chromium, Page } from 'playwright';
import * as fs from 'fs';
import * as path from 'path';

const appsToVerify = [
    { name: 'primecare_auth', url: 'https://primecare-auth.pages.dev/login', dbAppId: 3 },
    { name: 'primecare_governance', url: 'https://primecare-governance.pages.dev/login', dbAppId: 10 },
    { name: 'primecare_corporate', url: 'https://primecare-corporate.pages.dev/login', dbAppId: 7 },
    { name: 'primecare_franchise', url: 'https://primecare-franchise.pages.dev/login', dbAppId: 9 },
    { name: 'primecare_clinic', url: 'https://primecare-clinic.pages.dev/login', dbAppId: 6 },
    { name: 'primecare_client', url: 'https://primecare-client.pages.dev/login', dbAppId: 5 },
    { name: 'primecare_business_development', url: 'https://primecare-business-development.pages.dev/login', dbAppId: 4 },
    { name: 'primecare_marketing', url: 'https://primecare-marketing.pages.dev/login', dbAppId: 11 },
    { name: 'primecare_support', url: 'https://primecare-support.pages.dev/login', dbAppId: 12 },
    { name: 'primecare_enterprise_blueprint', url: 'https://primecare-enterprise-blueprint.pages.dev/login', dbAppId: 8 }
];

interface AuditResult {
    name: string;
    url: string;
    dbAppId: number;
    status: 'passed' | 'failed';
    durationMs: number;
    screenshotPath: string;
    logPath: string;
    consoleLogs: string[];
    domChecks: {
        bodyHasContent: boolean;
        hasFlutterView: boolean;
        hasErrorBoundary: boolean;
        domNodeCount: number;
    };
    errorMessage?: string;
}

async function verifyApp(browser: any, app: typeof appsToVerify[0], artifactsDir: string): Promise<AuditResult> {
    const context = await browser.newContext({
        viewport: { width: 1440, height: 900 }
    });
    const page = await context.newPage();
    const startTime = Date.now();
    const consoleLogs: string[] = [];
    let errorMessage = '';

    // Listen for console logs
    page.on('console', msg => {
        const text = `[${msg.type()}] ${msg.text()}`;
        consoleLogs.push(text);
        if (msg.type() === 'error') {
            console.error(`  [CONSOLE ERROR] ${msg.text()}`);
        }
    });

    // Listen for page errors
    page.on('pageerror', err => {
        consoleLogs.push(`[CRASH] Page Error: ${err.message}\nStack: ${err.stack}`);
        errorMessage += `Unhandled JS exception: ${err.message}; `;
        console.error(`  [PAGE ERROR] ${err.message}`);
    });

    console.log(`\n🔍 Auditing: ${app.name} -> ${app.url}`);
    
    try {
        // Navigate with a generous 30s timeout
        await page.goto(app.url, { waitUntil: 'load', timeout: 30000 });
        
        // Wait 10 seconds for the Flutter WASM/JS engine to fully bootstrap and mount components
        console.log(`  Waiting 10s for Flutter engine bootstrap...`);
        await page.waitForTimeout(10000);

        // Perform DOM audits
        const domInfo = await page.evaluate(() => {
            const bodyText = document.body.innerText || '';
            const errorBoundaryText = 'MECHANICAL FIX IN PROGRESS';
            
            return {
                bodyHasContent: document.body.innerHTML.trim().length > 100,
                hasFlutterView: !!(document.querySelector('flutter-view') || document.querySelector('flt-glass-pane') || document.querySelector('flt-semantics')),
                hasErrorBoundary: bodyText.includes(errorBoundaryText),
                domNodeCount: document.getElementsByTagName('*').length
            };
        });

        // Determine health status
        let status: 'passed' | 'failed' = 'passed';
        if (!domInfo.bodyHasContent) {
            status = 'failed';
            errorMessage += 'DOM body is empty (Blank Screen detected); ';
        }
        if (domInfo.hasErrorBoundary) {
            status = 'failed';
            errorMessage += 'AppErrorBoundary loop triggered; ';
        }
        
        // C CISOs often get false positives from network timeouts. Let's make sure it's not a dummy layout.
        if (status === 'passed') {
            console.log(`  ✅ Live DOM Verification Passed (${domInfo.domNodeCount} active elements).`);
        } else {
            console.warn(`  ❌ Verification Failed: ${errorMessage}`);
        }

        // Capture visual proof
        const screenshotPath = path.join(artifactsDir, `live_verification_${app.name}.png`);
        await page.screenshot({ path: screenshotPath });
        console.log(`  📸 Screenshot saved to: ${screenshotPath}`);

        // Save console log file
        const logPath = path.join(artifactsDir, `console_logs_${app.name}.log`);
        fs.writeFileSync(logPath, consoleLogs.join('\n'), 'utf-8');

        return {
            name: app.name,
            url: app.url,
            dbAppId: app.dbAppId,
            status,
            durationMs: Date.now() - startTime,
            screenshotPath,
            logPath,
            consoleLogs,
            domChecks: domInfo,
            errorMessage: errorMessage ? errorMessage.trim() : undefined
        };

    } catch (e: any) {
        console.error(`  ❌ Critical failure loading app: ${e.message}`);
        
        // Capture fallback screenshot if page exists
        const screenshotPath = path.join(artifactsDir, `live_verification_${app.name}_failed.png`);
        try {
            await page.screenshot({ path: screenshotPath });
        } catch (_) {}

        const logPath = path.join(artifactsDir, `console_logs_${app.name}.log`);
        fs.writeFileSync(logPath, consoleLogs.concat([`Critical Navigation Failure: ${e.message}`]).join('\n'), 'utf-8');

        return {
            name: app.name,
            url: app.url,
            dbAppId: app.dbAppId,
            status: 'failed',
            durationMs: Date.now() - startTime,
            screenshotPath,
            logPath,
            consoleLogs,
            domChecks: { bodyHasContent: false, hasFlutterView: false, hasErrorBoundary: false, domNodeCount: 0 },
            errorMessage: `Navigation failed: ${e.message}`
        };
    } finally {
        await page.close();
        await context.close();
    }
}

async function run() {
    const artifactsDir = path.join(__dirname, '..', 'artifacts');
    if (!fs.existsSync(artifactsDir)) {
        fs.mkdirSync(artifactsDir, { recursive: true });
    }

    console.log('🏁 Launching Playwright Chromium Headless Instance...');
    const browser = await chromium.launch({ headless: true });
    
    const results: AuditResult[] = [];
    for (const app of appsToVerify) {
        const res = await verifyApp(browser, app, artifactsDir);
        results.push(res);
    }

    await browser.close();
    console.log('🏁 Playwright Chromium Instance Closed.');

    const resultsPath = path.join(artifactsDir, 'render_verification_results.json');
    fs.writeFileSync(resultsPath, JSON.stringify(results, null, 2), 'utf-8');
    console.log(`Saved results database schema input to: ${resultsPath}`);
}

run().catch(e => {
    console.error('Fatal crash inside Render Quality Verification Engine:', e);
    process.exit(1);
});
