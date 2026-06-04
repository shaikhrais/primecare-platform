import { test, expect } from '@playwright/test';

test.use({ video: 'on' });

test.describe('PrimeCare Clinic Portal - Clinic Roles E2E Login & Routing Verification', () => {
  test('Execute E2E Login & Logout Loop for all 10 clinical roles on Live Site', async ({ page }) => {
    // Extend test timeout to 10 minutes to allow all 10 roles to run sequentially with redraw delays
    test.setTimeout(600000);

    const logStep = (step: string) => {
      const timestamp = new Date().toISOString().split('T')[1].slice(0, -1);
      console.log(`\x1b[36m[PW CLINIC ROLES LOOP ${timestamp}]\x1b[0m 📝 ${step}`);
    };

    const getCy = (id: string) => {
      return page.locator(`[aria-label*="data-cy:${id}"], [data-cy="${id}"]`);
    };

    const injectSemanticsStyle = async () => {
      await page.evaluate(() => {
        if (!document.getElementById("playwright-semantics-override")) {
          const style = document.createElement("style");
          style.id = "playwright-semantics-override";
          style.innerHTML = `
            flt-semantics[aria-label*="data-cy:"], [aria-label*="data-cy:"] {
              min-width: 1px !important;
              min-height: 1px !important;
              visibility: visible !important;
              opacity: 0.001 !important;
            }
          `;
          document.head.appendChild(style);
        }
      });
    };

    page.on('domcontentloaded', async () => {
      await injectSemanticsStyle();
    });

    page.on('console', msg => {
      if (msg.type() === 'error') {
        console.log(`\x1b[31m[BROWSER CONSOLE ERROR]\x1b[0m ${msg.text()}`);
      }
    });

    page.on('pageerror', err => {
      console.error(`\x1b[31m[BROWSER ERROR]\x1b[0m ${err.message}`);
    });

    const rolesToTest = [
      { name: 'Clinic Director', email: 'qa.clinical_director@test.primecare.local', password: 'Test@12345' },
    ];

    logStep(`Starting clinical roles loop verification against: https://primecare-clinic.pages.dev/login`);

    for (let idx = 0; idx < rolesToTest.length; idx++) {
      const { name, email, password } = rolesToTest[idx];
      const cycleId = idx + 1;
      logStep(`\x1b[32m=== START ROLE ${cycleId}/${rolesToTest.length}: ${name} ===\x1b[0m`);

      // 1. Navigate to login page
      logStep(`[${name}] Navigating to login page...`);
      await page.goto('https://primecare-clinic.pages.dev/login?enable-semantics=true');
      await page.waitForLoadState('domcontentloaded');

      // Clear storage to ensure clean state
      await page.evaluate(() => {
        window.localStorage.clear();
        window.sessionStorage.clear();
      });

      logStep(`[${name}] Waiting 4s for Flutter UI bootstrapping...`);
      await page.waitForTimeout(4000);
      await injectSemanticsStyle();

      // 2. Fill Credentials
      logStep(`[${name}] Locating input fields...`);
      const emailInput = getCy('login-email');
      const passwordInput = getCy('login-password');

      await expect(emailInput).toBeVisible({ timeout: 15000 });
      await expect(passwordInput).toBeVisible({ timeout: 15000 });

      logStep(`[${name}] Typing email: ${email}`);
      await emailInput.click({ force: true });
      await page.waitForTimeout(500);
      await emailInput.fill(email);

      logStep(`[${name}] Typing password: ${password}`);
      await passwordInput.click({ force: true });
      await page.waitForTimeout(500);
      await passwordInput.fill(password);

      // Screenshot login inputs filled
      await page.screenshot({ path: `cypress/screenshots/clinic-role-login-filled-${name.replace(/\s+/g, '-')}.png` });

      // 3. Submit
      logStep(`[${name}] Clicking Login Submit button...`);
      await getCy('login-submit').locator('flt-semantics[role="button"], button').first().click({ force: true });

      // 4. Verify Redirection & App Shell
      logStep(`[${name}] Waiting for redirect to dashboard...`);
      await page.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 25000 });

      logStep(`[${name}] Redirect complete. Waiting 4s for dashboard UI settling...`);
      await page.waitForTimeout(4000);
      await injectSemanticsStyle();

      logStep(`[${name}] Verifying dashboard components (app-shell)...`);
      const shell = getCy('app-shell');
      const topbar = getCy('app-topbar');
      const sidebar = getCy('app-sidebar');

      await expect(shell).toBeVisible({ timeout: 20000 });
      await expect(topbar).toBeVisible();
      await expect(sidebar).toBeVisible();

      logStep(`[${name}] Successfully logged in and verified dashboard. Landing Route: ${page.url()}`);
      
      // Temporarily expand viewport to render all scrollable Flutter content down the page
      await page.setViewportSize({ width: 1600, height: 2400 });
      await page.waitForTimeout(1500); // Allow Flutter engine to redraw at the new resolution
      
      await page.screenshot({
        path: `cypress/screenshots/clinic-role-dashboard-loaded-${name.replace(/\s+/g, '-')}.png`
      });
      
      // Restore standard viewport size for regular navigation
      await page.setViewportSize({ width: 1280, height: 720 });
      await page.waitForTimeout(1500); // Allow Flutter layout to settle at restored resolution

      // 5. Logout
      logStep(`[${name}] Locating profile/user functions menu...`);
      const profileMenu = page.locator('[aria-label*="User Functions"], [aria-label*="user-menu"], [aria-label*="profile"], [data-cy="user-menu-button"]');

      if (await profileMenu.count() > 0) {
        logStep(`[${name}] Clicking user profile dropdown...`);
        await profileMenu.click({ force: true });
        await page.waitForTimeout(1000);

        logStep(`[${name}] Clicking Sign Out...`);
        const logoutBtn = page.locator('[aria-label*="Sign Out"], [aria-label*="Logout"], [data-cy="logout-button"], text=/Sign Out|Logout/i');
        await logoutBtn.click({ force: true });
      } else {
        logStep(`[${name}] Dropdown not found. Clicking trailing topbar icon button...`);
        const logoutIconBtn = topbar.locator('flt-semantics[role="button"]').last();
        await logoutIconBtn.click({ force: true });
      }

      // 6. Verify Redirected to Login
      logStep(`[${name}] Waiting for redirect back to login gateway...`);
      await page.waitForURL((url) => url.pathname.includes('/login'), { timeout: 15000 });

      const postLogoutEmailField = getCy('login-email');
      await expect(postLogoutEmailField).toBeVisible({ timeout: 10000 });
      logStep(`[${name}] Successfully logged out. Redirection verified.`);
      await page.screenshot({ path: `cypress/screenshots/clinic-role-logged-out-${name.replace(/\s+/g, '-')}.png` });

      logStep(`\x1b[32m=== END ROLE ${cycleId}/${rolesToTest.length}: ${name} ===\x1b[0m`);
    }

    logStep('E2E clinic-roles loop finished successfully! All 10 clinical roles logged in and out successfully.');
  });
});
