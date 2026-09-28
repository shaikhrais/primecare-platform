const { chromium } = require('playwright');
const path = require('path');

const DEST_DIR = "C:\\Users\\Admin2\\.gemini\g\\antigravity-ide\\brain\\26b1218b-e518-4477-8a4e-2789a840acc1";
// Fix the malformed path above (remove the \g\ typo)
const CORRECT_DEST_DIR = "C:\\Users\\Admin2\\.gemini\\antigravity-ide\\brain\\26b1218b-e518-4477-8a4e-2789a840acc1";
const SCREENSHOT_PATH = path.join(CORRECT_DEST_DIR, "psw_dashboard_clean.png");

async function main() {
  console.log("==============================================================");
  console.log("ENTERPRISE PLAYWRIGHT AUTH & DASHBOARD SCREENSHOT VERIFIER");
  console.log("==============================================================");

  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 }
  });

  // Seed local storage BEFORE navigation to bypass the language selection screen
  await context.addInitScript(() => {
    console.log("Seeding local storage keys...");
    window.localStorage.setItem("flutter.auth_language_selected", "true");
    window.localStorage.setItem("flutter.auth_preferred_language", JSON.stringify("en"));
    window.localStorage.setItem("flutter.clinic_language_selected", "true");
    window.localStorage.setItem("flutter.clinic_preferred_language", JSON.stringify("en"));
  });

  const page = await context.newPage();

  // Mock token and responses
  const mockToken = "mock-jwt-token-psw";
  const mockUserId = "test-user-id-psw";
  const mockUserEmail = "qa.psw@test.primecare.local";

  const mockLoginResponse = {
    status: "success",
    token: mockToken,
    userId: mockUserId,
    role: "psw",
    userName: "Active User",
    tenantId: "primecare_hq"
  };

  const mockUserResponse = {
    token: mockToken,
    role: "psw",
    roles: "psw",
    userId: mockUserId,
    tenantId: "primecare_hq",
    activeRole: "psw",
    user: {
      id: mockUserId,
      firstName: "QA",
      lastName: "PSW",
      roles: ["psw"],
      tenantId: "primecare_hq",
      preferredLanguage: "en",
      email: mockUserEmail
    }
  };

  // Setup API routing / intercepts in Playwright context
  await page.route('**/login', async route => {
    console.log(`[PLAYWRIGHT MOCK] Intercepted POST login request`);
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify(mockLoginResponse)
    });
  });

  await page.route('**/auth/login', async route => {
    console.log(`[PLAYWRIGHT MOCK] Intercepted POST auth/login request`);
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify(mockLoginResponse)
    });
  });

  await page.route('**/auth/me', async route => {
    console.log(`[PLAYWRIGHT MOCK] Intercepted GET auth/me request`);
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify(mockUserResponse)
    });
  });

  await page.route('**/me', async route => {
    console.log(`[PLAYWRIGHT MOCK] Intercepted GET me request`);
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify(mockUserResponse)
    });
  });

  // Mock the clinic psw list API loaded by CareDashboardScreen
  await page.route('**/v1/psw', async route => {
    console.log(`[PLAYWRIGHT MOCK] Intercepted GET /v1/psw list request`);
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({
        status: "success",
        data: [
          { id: 1, name: "Simulation Log 1", timestamp: new Date().toISOString() },
          { id: 2, name: "Simulation Log 2", timestamp: new Date().toISOString() }
        ]
      })
    });
  });

  // Open the clinic-local shared login page
  const loginUrl = "https://primecare-clinic.pages.dev/login?enable-semantics=true";
  console.log(`Navigating to login page: ${loginUrl}`);
  await page.goto(loginUrl);

  // Wait for Flutter web load
  await page.waitForTimeout(6000);

  // Inject semantic helper stylesheet to expose interactive controls
  console.log("Injecting CSS rules to expose semantic interactions...");
  await page.addStyleTag({
    content: `
      flt-semantics[aria-label*="data-cy:"], [aria-label*="data-cy:"], flt-semantics[aria-label], [aria-label] {
        min-width: 1px !important;
        min-height: 1px !important;
        visibility: visible !important;
        opacity: 0.1 !important;
      }
    `
  });
  await page.waitForTimeout(1000);

  // Check if we are still on the language view despite local storage seeding (fallback)
  const languageButton = page.locator('[aria-label*="language-continue-button"], [aria-label*="CONTINUE"]').first();
  const isLanguageScreen = await languageButton.isVisible().catch(() => false);
  if (isLanguageScreen) {
    console.log("Fallback: Language Selection Screen detected. Clicking US English and CONTINUE...");
    // Click English semantic button
    await page.locator('[aria-label*="English"], [aria-label*="🇺🇸"]').first().click().catch(() => {});
    await page.waitForTimeout(500);
    await languageButton.click();
    console.log("Wait for redirection to login screen...");
    await page.waitForTimeout(4000);
  }

  // Fill in email
  console.log("Typing login-email...");
  const emailInput = page.locator([
    '[aria-label*="login-email"] input',
    'input[aria-label*="login-email"]',
    '[aria-label*="login-email"] textarea',
    '[aria-label*="login-email"]',
    'input'
  ].join(', ')).first();
  await emailInput.fill(mockUserEmail);
  await page.waitForTimeout(500);

  // Fill in password
  console.log("Typing login-password...");
  const passwordInput = page.locator([
    '[aria-label*="login-password"] input',
    'input[aria-label*="login-password"]',
    '[aria-label*="login-password"] textarea',
    '[aria-label*="login-password"]',
    'input[type="password"]'
  ].join(', ')).first();
  await passwordInput.fill("Test@12345");
  await page.waitForTimeout(500);

  // Click submit button
  console.log("Clicking login-submit...");
  const submitButton = page.locator([
    '[aria-label*="login-submit"]',
    '[data-cy="login-submit"]',
    '[aria-label*="login-submit"] flt-semantics',
    'button[aria-label*="submit"]',
    '[aria-label*="Sign In"]'
  ].join(', ')).first();
  await submitButton.click();

  console.log("Waiting for redirection and page loading (12 seconds)...");
  await page.waitForTimeout(12000);

  // Verify the redirected URL contains psw dashboard
  const currentUrl = page.url();
  console.log(`Current URL: ${currentUrl}`);

  if (currentUrl.includes("/psw/dashboard") || currentUrl.includes("/dashboard")) {
    console.log("Success! Authenticated session restored and landed on psw/dashboard.");
  } else {
    console.log("Warning: Current URL does not match psw/dashboard. Proceeding with screenshot anyway.");
  }

  // Inject same semantic rules in case redirection re-loaded them
  try {
    await page.addStyleTag({
      content: `
        flt-semantics[aria-label*="data-cy:"], [aria-label*="data-cy:"], flt-semantics[aria-label], [aria-label] {
          min-width: 1px !important;
          min-height: 1px !important;
          visibility: visible !important;
          opacity: 0.1 !important;
        }
      `
    });
  } catch (e) {}

  await page.waitForTimeout(3000);

  // Take screenshot
  console.log(`Taking screenshot to: ${SCREENSHOT_PATH}`);
  await page.screenshot({ path: SCREENSHOT_PATH, fullPage: true });

  console.log("Screenshot successfully saved!");
  await browser.close();
}

main().catch(err => {
  console.error("Playwright automation failed with error:", err);
  process.exit(1);
});
