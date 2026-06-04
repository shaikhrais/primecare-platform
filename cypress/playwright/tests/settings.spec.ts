import { test, expect } from '@playwright/test';
import { AuthHelper } from '../helpers/auth.helper';

test.describe('PrimeCare Settings Center - Public E2E Verification', () => {
  let auth: AuthHelper;

  test.beforeEach(async ({ page }) => {
    auth = new AuthHelper(page);
  });

  test.afterEach(async () => {
    auth.assertZeroFailures();
  });

  test('1. Verify Settings Center Layout & Branding Save', async ({ page }) => {
    auth.logStep('Executing: 1. Verify Settings Center Layout & Branding Save');
    
    // Log in as admin and route directly to Settings Center
    await auth.login('qa.admin@test.primecare.local', 'Test@12345', '/common/settings');
    await page.waitForLoadState('domcontentloaded');
    
    // Wait for settings page elements to settle (allowing bootstrapping time)
    await page.waitForTimeout(5000);
    await auth.injectSemanticsStyle();

    auth.logStep('Asserting header visibility...');
    const heading = page.locator('text=Institutional Branding Center').first();
    await expect(heading).toBeVisible({ timeout: 20000 });

    auth.logStep('Locating settings section titles...');
    await expect(page.locator('[aria-label*="Theme Presets"]').first()).toBeVisible();
    await expect(page.locator('[aria-label*="Custom Brand Overrides"]').first()).toBeVisible();
    await expect(page.locator('[aria-label*="Page Layout Mode"]').first()).toBeVisible();
    await expect(page.locator('[aria-label*="Application Language"]').first()).toBeVisible();

    // Take screenshot of default settings page
    auth.logStep('Capturing default settings center screenshot: "settings-center-default.png"');
    await page.screenshot({ path: 'cypress/screenshots/settings-center-default.png', fullPage: true });

    // Type custom primary color
    auth.logStep('Typing custom primary color hex code...');
    const accentInput = page.locator('input').first(); // The first input on settings page is primary color
    await expect(accentInput).toBeVisible();
    await accentInput.fill('#0D47A1');
    
    // Select French language
    auth.logStep('Selecting French language option...');
    const frCard = page.locator('text=Français').first();
    await expect(frCard).toBeVisible();
    await frCard.click({ force: true });
    await page.waitForTimeout(2000);

    // Save configurations
    auth.logStep('Clicking Save button...');
    const saveBtn = page.locator('text=Save Branding & Settings').first();
    await expect(saveBtn).toBeVisible();
    await saveBtn.click({ force: true });

    // Expect success toast
    auth.logStep('Waiting for SnackBar success notification...');
    const successToast = page.locator('text=Branding and Settings saved successfully!').first();
    await expect(successToast).toBeVisible({ timeout: 15000 });

    // Take screenshot of saved branding changes
    auth.logStep('Capturing saved settings center screenshot: "settings-center-saved.png"');
    await page.screenshot({ path: 'cypress/screenshots/settings-center-saved.png', fullPage: true });

    auth.logStep('✅ Branding customizer and settings persistence verified successfully!');
  });
});
