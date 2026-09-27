import { test, expect } from '@playwright/test';

test.use({ video: 'on' });

test.describe('PrimeCare Clinic - Live Login/Logout E2E Loop', () => {
  // We configure video option inside the test run configuration
  test('Execute E2E Login & Logout Loop 3 times on Live Site', async ({ page }) => {
    const logStep = (step: string) => {
      const timestamp = new Date().toISOString().split('T')[1].slice(0, -1);
      console.log(`\x1b[36m[PW LIVE LOOP ${timestamp}]\x1b[0m 📝 ${step}`);
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
      console.log(`\x1b[33m[BROWSER CONSOLE]\x1b[0m ${msg.type()}: ${msg.text()}`);
    });
    page.on('pageerror', err => {
      console.error(`\x1b[31m[BROWSER ERROR]\x1b[0m ${err.message}`);
    });
    page.on('requestfailed', request => {
      console.error(`\x1b[31m[BROWSER REQUEST FAILED]\x1b[0m ${request.url()} - ${request.failure()?.errorText}`);
    });

    logStep('Starting E2E loop against: https://primecare-clinic.pages.dev/login');

    for (let i = 1; i <= 3; i++) {
      logStep(`\x1b[32m=== START CYCLE ${i} ===\x1b[0m`);

      // 1. Navigate to login page
      logStep(`[Cycle ${i}] Navigating to login page...`);
      await page.goto('https://primecare-clinic.pages.dev/login?enable-semantics=true');
      await page.waitForLoadState('domcontentloaded');
      
      // Clear storage to ensure clean state
      await page.evaluate(() => {
        window.localStorage.clear();
        window.sessionStorage.clear();
      });

      logStep(`[Cycle ${i}] Waiting 4s for Flutter UI bootstrapping...`);
      await page.waitForTimeout(4000);
      await injectSemanticsStyle();

      // 2. Sanity Check Sign Up Dialog (Only run once in first loop to save time)
      if (i === 1) {
        logStep('[Cycle 1] Locating Sign Up link...');
        const signUpLink = page.getByRole('button', { name: /Sign Up/i }).first();
        await expect(signUpLink).toBeVisible({ timeout: 15000 });
        
        logStep('[Cycle 1] Clicking Sign Up link...');
        await signUpLink.click({ force: true });
        await page.waitForTimeout(1500);

        logStep('[Cycle 1] Verifying Access Request dialog is shown...');
        // We look for the "Access Request" text or dialog container
        const understoodBtn = page.getByRole('button', { name: /UNDERSTOOD/i }).first();
        await expect(understoodBtn).toBeVisible({ timeout: 10000 });
        
        await page.screenshot({ path: `cypress/screenshots/live-signup-dialog.png` });

        logStep('[Cycle 1] Clicking UNDERSTOOD to dismiss dialog...');
        await understoodBtn.click({ force: true });
        await page.waitForTimeout(1000);
      }

      // 3. Fill Credentials
      logStep(`[Cycle ${i}] Locating input fields...`);
      const emailInput = getCy('login-email');
      const passwordInput = getCy('login-password');
      const submitBtn = getCy('login-submit');

      await expect(emailInput).toBeVisible({ timeout: 15000 });
      await expect(passwordInput).toBeVisible({ timeout: 15000 });

      logStep(`[Cycle ${i}] Typing email: psw@demo.primecare.com`);
      await emailInput.click({ force: true });
      await page.waitForTimeout(500);
      await emailInput.fill('psw@demo.primecare.com');
      
      logStep(`[Cycle ${i}] Typing password: demoPassword123`);
      await passwordInput.click({ force: true });
      await page.waitForTimeout(500);
      await passwordInput.fill('demoPassword123');

      // Screenshot login inputs filled
      await page.screenshot({ path: `cypress/screenshots/live-login-filled-cycle-${i}.png` });

      // 4. Submit
      logStep(`[Cycle ${i}] Clicking Login Submit button...`);
      await getCy('login-submit').locator('flt-semantics[role="button"], button').first().click({ force: true });

      // 5. Verify Redirection & App Shell
      logStep(`[Cycle ${i}] Waiting for redirect to dashboard...`);
      await page.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 25000 });
      
      logStep(`[Cycle ${i}] Redirect complete. Waiting 4s for dashboard UI settling...`);
      await page.waitForTimeout(4000);
      await injectSemanticsStyle();

      logStep(`[Cycle ${i}] Verifying dashboard components (app-shell)...`);
      const shell = getCy('app-shell');
      const topbar = getCy('app-topbar');
      const sidebar = getCy('app-sidebar');
      
      await expect(shell).toBeVisible({ timeout: 20000 });
      await expect(topbar).toBeVisible();
      await expect(sidebar).toBeVisible();

      logStep(`[Cycle ${i}] Successfully logged in and verified dashboard.`);
      await page.screenshot({ path: `cypress/screenshots/live-dashboard-loaded-cycle-${i}.png` });

      // 6. Logout
      logStep(`[Cycle ${i}] Locating profile/user functions menu...`);
      const profileMenu = page.locator('[aria-label*="User Functions"], [aria-label*="user-menu"], [aria-label*="profile"], [data-cy="user-menu-button"]');
      
      if (await profileMenu.count() > 0) {
        logStep(`[Cycle ${i}] Clicking user profile dropdown...`);
        await profileMenu.click({ force: true });
        await page.waitForTimeout(1000);

        logStep(`[Cycle ${i}] Clicking Sign Out...`);
        const logoutBtn = page.locator('[aria-label*="Sign Out"], [aria-label*="Logout"], [data-cy="logout-button"], text=/Sign Out|Logout/i');
        await logoutBtn.click({ force: true });
      } else {
        logStep(`[Cycle ${i}] Dropdown not found. Clicking trailing topbar icon button...`);
        const logoutIconBtn = topbar.locator('flt-semantics[role="button"]').last();
        await logoutIconBtn.click({ force: true });
      }

      // 7. Verify Redirected to Login
      logStep(`[Cycle ${i}] Waiting for redirect back to login gateway...`);
      await page.waitForURL((url) => url.pathname.includes('/login'), { timeout: 15000 });
      
      const postLogoutEmailField = getCy('login-email');
      await expect(postLogoutEmailField).toBeVisible({ timeout: 10000 });
      logStep(`[Cycle ${i}] Successfully logged out. Redirection verified.`);
      await page.screenshot({ path: `cypress/screenshots/live-logged-out-cycle-${i}.png` });

      logStep(`\x1b[32m=== END CYCLE ${i} ===\x1b[0m`);
    }

    logStep('E2E loop finished successfully! 3 full cycles of login and logout completed.');
  });
});
