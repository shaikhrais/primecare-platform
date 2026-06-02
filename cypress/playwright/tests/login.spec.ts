import { test, expect } from '@playwright/test';
import { AuthHelper } from '../helpers/auth.helper';

test.describe('PrimeCare Clinic - End-to-End Governance Suite', () => {
  let auth: AuthHelper;

  test.beforeEach(async ({ page }) => {
    auth = new AuthHelper(page);
  });

  test.afterEach(async () => {
    auth.assertZeroFailures();
  });

  test('1. Verify Login Form Layout & Field Constraints', async () => {
    auth.logStep('Executing: 1. Verify Login Form Layout & Field Constraints');
    await auth.navigateToLogin();

    const emailField = auth.getCy('login-email');
    const passwordField = auth.getCy('login-password');
    const submitBtn = auth.getCy('login-submit');

    auth.logStep('Verifying input inputs are visible and interactive...');
    await expect(emailField).toBeVisible();
    await expect(passwordField).toBeVisible();
    await expect(submitBtn).toBeVisible();
  });

  test('2. Multi-Viewport Responsive Layout Audit & Screenshots', async ({ page }) => {
    auth.logStep('Executing: 2. Multi-Viewport Responsive Layout Audit & Screenshots');

    // Register network mocks and navigate to the page ONCE
    await auth.setupNetworkMocks();
    auth.logStep('Navigating to login page for viewport testing...');
    await page.goto('/login?enable-semantics=true');
    await page.waitForLoadState('networkidle');
    await expect(auth.getCy('login-email')).toBeVisible({ timeout: 20000 });

    const viewports = [
      { name: '4k', width: 3840, height: 2160 },
      { name: '3k', width: 3000, height: 2000 },
      { name: '2k', width: 2560, height: 1440 },
      { name: '1k', width: 1920, height: 1080 },
      { name: 'tab', width: 768, height: 1024 },
      { name: 'mob', width: 375, height: 812 },
    ];

    for (const vp of viewports) {
      auth.logStep(`Evaluating responsive layout for viewport: ${vp.name} (${vp.width}x${vp.height})`);
      await page.setViewportSize({ width: vp.width, height: vp.height });
      await page.waitForTimeout(500); // Allow responsive layout settling

      const screenshotName = `login-${vp.name}.png`;
      auth.logStep(`Saving viewport snapshot to: "${screenshotName}"`);
      await page.screenshot({ path: `cypress/screenshots/${screenshotName}` });

      const emailField = auth.getCy('login-email');
      const passwordField = auth.getCy('login-password');
      await expect(emailField).toBeVisible();
      await expect(passwordField).toBeVisible();
    }
  });

  test('3. Complete Authentication Flow & Dashboard Landing', async ({ page }) => {
    auth.logStep('Executing: 3. Complete Authentication Flow & Dashboard Landing');
    await auth.navigateToLogin();

    auth.logStep('Saving baseline login screenshot: "login-page.png"');
    await page.screenshot({ path: 'cypress/screenshots/login-page.png' });

    await auth.login();
    await auth.verifyDashboard();

    const topbar = auth.getCy('app-topbar');
    auth.logStep('Verifying user identity is displayed in session headers...');
    await expect(topbar).toContainText(/Active User|chiropractor|dentist/i);

    auth.logStep('Saving authenticated dashboard screenshot: "dashboard-after-login.png"');
    await page.screenshot({ path: 'cypress/screenshots/dashboard-after-login.png' });
  });

  test('4. Session Persistence Across Page Refreshes', async ({ page }) => {
    auth.logStep('Executing: 4. Session Persistence Across Page Refreshes');
    await auth.navigateToLogin();
    await auth.login();
    await auth.verifyDashboard();

    auth.logStep('Simulating page refresh / browser reload...');
    await page.reload({ waitUntil: 'domcontentloaded' });
    
    await auth.verifyDashboard();
    auth.logStep('✅ Session successfully persisted post page reload.');
  });

  test('5. Zero-Trust Access Boundary Isolation & Logout Lifecycle', async ({ page }) => {
    auth.logStep('Executing: 5. Zero-Trust Access Boundary Isolation & Logout Lifecycle');
    await auth.navigateToLogin();
    await auth.login();
    await auth.verifyDashboard();

    const dashboardUrl = page.url();
    auth.logStep(`Session active on page: ${dashboardUrl}`);

    await auth.logout();

    auth.logStep('Saving session termination screenshot: "logout-success.png"');
    await page.screenshot({ path: 'cypress/screenshots/logout-success.png' });

    auth.logStep(`Security Auditing: Re-navigating back to protected page: ${dashboardUrl}`);
    await page.goto(dashboardUrl);
    
    await page.waitForURL((url) => url.pathname.includes('/login'), { timeout: 15000 });
    
    const emailField = auth.getCy('login-email');
    await expect(emailField).toBeVisible();

    auth.logStep('Security Auditing: Attempting browser back navigation injection...');
    await page.goBack();
    
    await page.waitForTimeout(2000);
    expect(page.url()).not.toContain(dashboardUrl);
    await expect(emailField).toBeVisible();

    auth.logStep('✅ Access Guard verified: Protected pages are completely inaccessible post-session destruction.');
  });

  test('6. Dynamic Language Change & Locale Persistence Lifecycle', async ({ page }) => {
    auth.logStep('Executing: 6. Dynamic Language Change & Locale Persistence Lifecycle');
    await auth.navigateToLogin();
    await auth.login();
    await auth.verifyDashboard();

    // Target the language switcher using Playwright's native getByRole accessibility selector
    const langSwitcher = page.getByRole('button', { name: /topbar-language-switcher/i });
    await expect(langSwitcher).toBeVisible({ timeout: 15000 });

    // 1. Switch to French
    auth.logStep('Opening language selector to choose French...');
    await langSwitcher.click({ force: true });
    await page.waitForTimeout(1500);

    // Locate the French option robustly using getByRole
    let frOption = page.getByRole('button', { name: /topbar-language-option-fr/i }).first();
    if (await frOption.count() === 0) {
      frOption = auth.getCy('topbar-language-option-fr');
    }
    await expect(frOption).toBeVisible({ timeout: 10000 });
    await frOption.click({ force: true });
    await page.waitForTimeout(2500); // Allow translations to hot-reload

    auth.logStep('Saving French layout screenshot: "language-fr.png"');
    await page.screenshot({ path: 'cypress/screenshots/language-fr.png' });

    // Verify localStorage persistence for 'fr' (parsing JSON format used by shared_preferences_web)
    const frPersisted = await page.evaluate(() => {
      const raw = window.localStorage.getItem('flutter.auth_preferred_language') || '';
      try { return JSON.parse(raw); } catch { return raw; }
    });
    expect(frPersisted).toBe('fr');
    auth.logStep('✅ French locale successfully persisted in browser storage.');

    // 2. Switch to Spanish
    auth.logStep('Opening language selector to choose Spanish...');
    await langSwitcher.click({ force: true });
    await page.waitForTimeout(1500);

    // Locate the Spanish option robustly using getByRole
    let esOption = page.getByRole('button', { name: /topbar-language-option-es/i }).first();
    if (await esOption.count() === 0) {
      esOption = auth.getCy('topbar-language-option-es');
    }
    await expect(esOption).toBeVisible({ timeout: 10000 });
    await esOption.click({ force: true });
    await page.waitForTimeout(2500); // Allow translations to hot-reload

    auth.logStep('Saving Spanish layout screenshot: "language-es.png"');
    await page.screenshot({ path: 'cypress/screenshots/language-es.png' });

    // Verify localStorage persistence for 'es'
    const esPersisted = await page.evaluate(() => {
      const raw = window.localStorage.getItem('flutter.auth_preferred_language') || '';
      try { return JSON.parse(raw); } catch { return raw; }
    });
    expect(esPersisted).toBe('es');
    auth.logStep('✅ Spanish locale successfully persisted in browser storage.');

    // 3. Revert back to English
    auth.logStep('Reverting language choice back to English...');
    await langSwitcher.click({ force: true });
    await page.waitForTimeout(1500);

    // Locate the English option robustly using getByRole
    let enOption = page.getByRole('button', { name: /topbar-language-option-en/i }).first();
    if (await enOption.count() === 0) {
      enOption = auth.getCy('topbar-language-option-en');
    }
    await expect(enOption).toBeVisible({ timeout: 10000 });
    await enOption.click({ force: true });
    await page.waitForTimeout(2500);

    auth.logStep('Saving English layout screenshot: "language-en.png"');
    await page.screenshot({ path: 'cypress/screenshots/language-en.png' });

    const enPersisted = await page.evaluate(() => {
      const raw = window.localStorage.getItem('flutter.auth_preferred_language') || '';
      try { return JSON.parse(raw); } catch { return raw; }
    });
    expect(enPersisted).toBe('en');
    auth.logStep('✅ English locale successfully restored and persisted.');
  });

  test('7. Login Page Dynamic Localization Screenshot Capture', async ({ page }) => {
    auth.logStep('Executing: 7. Login Page Dynamic Localization Screenshot Capture');
    
    const selectLoginLanguage = async (lang: 'en' | 'fr' | 'es') => {
      auth.logStep(`Selecting language on login page: ${lang.toUpperCase()}`);
      
      // Target the language switcher using auth.getCy
      let switcher = auth.getCy('login-language-switcher').first();
      await expect(switcher).toBeVisible({ timeout: 15000 });
      await switcher.click({ force: true });
      await page.waitForTimeout(1000);
      
      // Locate the option robustly
      let option = auth.getCy(`login-language-option-${lang}`).first();
      await expect(option).toBeVisible({ timeout: 10000 });
      await option.click({ force: true });
      
      // Allow translations asset load and UI repaint
      await page.waitForTimeout(3000);
    };

    // 1. Load login page in English first
    await auth.navigateToLogin();
    
    // 2. Select French and capture screenshot
    await selectLoginLanguage('fr');
    auth.logStep('Saving French Login Page screenshot: "login-page-fr.png"');
    await page.screenshot({ path: 'cypress/screenshots/login-page-fr.png' });

    // 3. Select English to verify transition back
    await selectLoginLanguage('en');
    await page.waitForTimeout(1000);

    // 4. Select Spanish and capture screenshot
    await selectLoginLanguage('es');
    auth.logStep('Saving Spanish Login Page screenshot: "login-page-es.png"');
    await page.screenshot({ path: 'cypress/screenshots/login-page-es.png' });

    // 5. Restore default state
    await selectLoginLanguage('en');
    auth.logStep('✅ Login page native translation screenshots successfully generated.');
  });

  test('8. Capture Forgot Password Dialog Visual Asset', async ({ page }) => {
    auth.logStep('Executing: 8. Capture Forgot Password Dialog Visual Asset');
    await auth.navigateToLogin();
    
    // Target and click the Forgot Password link
    const forgotPasswordLink = page.getByRole('button', { name: /Forgot Password\?/i }).first();
    await expect(forgotPasswordLink).toBeVisible({ timeout: 10000 });
    await forgotPasswordLink.click({ force: true });
    await page.waitForTimeout(2000); // Allow dialog transition

    auth.logStep('Saving Forgot Password Dialog screenshot: "login-forgot-password.png"');
    await page.screenshot({ path: 'cypress/screenshots/login-forgot-password.png' });
    
    // Close the dialog
    const cancelBtn = page.getByRole('button', { name: /CANCEL/i }).first();
    await expect(cancelBtn).toBeVisible({ timeout: 10000 });
    await cancelBtn.click({ force: true });
    await page.waitForTimeout(1000);
    auth.logStep('✅ Forgot Password dialog visual verification successfully captured.');
  });
});
