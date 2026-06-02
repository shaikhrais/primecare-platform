# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: login.spec.ts >> PrimeCare Clinic - End-to-End Governance Suite >> 7. Login Page Dynamic Localization Screenshot Capture
- Location: cypress\playwright\tests\login.spec.ts:212:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('[aria-label*="data-cy:login-language-switcher"], [data-cy="login-language-switcher"]').first()
Expected: visible
Timeout: 15000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 15000ms
  - waiting for locator('[aria-label*="data-cy:login-language-switcher"], [data-cy="login-language-switcher"]').first()

```

```yaml
- button "Change Language data-cy:login-language-switcher EN"
- text: "SOC2 COMPLIANT · ISO 27001 PRIMECARE PLATFORM STABILITY & TRUST GOVERNED & SECURE ALL SYSTEMS OPERATIONAL SECURE DEPLOYMENT NODE: NA-EAST-1 ZERO-TRUST SESSION MANAGEMENT"
- group:
  - text: Authorized Access Enter your secure credentials to continue
  - textbox "data-cy:login-email USERNAME admin@primecare.com"
  - textbox "data-cy:login-password PASSWORD ••••••••"
  - button "Forgot Password?"
  - group "data-cy:login-submit":
    - button "LOGIN"
  - text: © 2026 PRIMECARE PLATFORM · SECURITY LAYER 4
```

# Test source

```ts
  120 |     await page.waitForTimeout(2000);
  121 |     expect(page.url()).not.toContain(dashboardUrl);
  122 |     await expect(emailField).toBeVisible();
  123 | 
  124 |     auth.logStep('✅ Access Guard verified: Protected pages are completely inaccessible post-session destruction.');
  125 |   });
  126 | 
  127 |   test('6. Dynamic Language Change & Locale Persistence Lifecycle', async ({ page }) => {
  128 |     auth.logStep('Executing: 6. Dynamic Language Change & Locale Persistence Lifecycle');
  129 |     await auth.navigateToLogin();
  130 |     await auth.login();
  131 |     await auth.verifyDashboard();
  132 | 
  133 |     // Target the language switcher using Playwright's native getByRole accessibility selector
  134 |     const langSwitcher = page.getByRole('button', { name: /topbar-language-switcher/i });
  135 |     await expect(langSwitcher).toBeVisible({ timeout: 15000 });
  136 | 
  137 |     // 1. Switch to French
  138 |     auth.logStep('Opening language selector to choose French...');
  139 |     await langSwitcher.click({ force: true });
  140 |     await page.waitForTimeout(1500);
  141 | 
  142 |     // Locate the French option robustly using getByRole
  143 |     let frOption = page.getByRole('button', { name: /topbar-language-option-fr/i }).first();
  144 |     if (await frOption.count() === 0) {
  145 |       frOption = auth.getCy('topbar-language-option-fr');
  146 |     }
  147 |     await expect(frOption).toBeVisible({ timeout: 10000 });
  148 |     await frOption.click({ force: true });
  149 |     await page.waitForTimeout(2500); // Allow translations to hot-reload
  150 | 
  151 |     auth.logStep('Saving French layout screenshot: "language-fr.png"');
  152 |     await page.screenshot({ path: 'cypress/screenshots/language-fr.png' });
  153 | 
  154 |     // Verify localStorage persistence for 'fr' (parsing JSON format used by shared_preferences_web)
  155 |     const frPersisted = await page.evaluate(() => {
  156 |       const raw = window.localStorage.getItem('flutter.auth_preferred_language') || '';
  157 |       try { return JSON.parse(raw); } catch { return raw; }
  158 |     });
  159 |     expect(frPersisted).toBe('fr');
  160 |     auth.logStep('✅ French locale successfully persisted in browser storage.');
  161 | 
  162 |     // 2. Switch to Spanish
  163 |     auth.logStep('Opening language selector to choose Spanish...');
  164 |     await langSwitcher.click({ force: true });
  165 |     await page.waitForTimeout(1500);
  166 | 
  167 |     // Locate the Spanish option robustly using getByRole
  168 |     let esOption = page.getByRole('button', { name: /topbar-language-option-es/i }).first();
  169 |     if (await esOption.count() === 0) {
  170 |       esOption = auth.getCy('topbar-language-option-es');
  171 |     }
  172 |     await expect(esOption).toBeVisible({ timeout: 10000 });
  173 |     await esOption.click({ force: true });
  174 |     await page.waitForTimeout(2500); // Allow translations to hot-reload
  175 | 
  176 |     auth.logStep('Saving Spanish layout screenshot: "language-es.png"');
  177 |     await page.screenshot({ path: 'cypress/screenshots/language-es.png' });
  178 | 
  179 |     // Verify localStorage persistence for 'es'
  180 |     const esPersisted = await page.evaluate(() => {
  181 |       const raw = window.localStorage.getItem('flutter.auth_preferred_language') || '';
  182 |       try { return JSON.parse(raw); } catch { return raw; }
  183 |     });
  184 |     expect(esPersisted).toBe('es');
  185 |     auth.logStep('✅ Spanish locale successfully persisted in browser storage.');
  186 | 
  187 |     // 3. Revert back to English
  188 |     auth.logStep('Reverting language choice back to English...');
  189 |     await langSwitcher.click({ force: true });
  190 |     await page.waitForTimeout(1500);
  191 | 
  192 |     // Locate the English option robustly using getByRole
  193 |     let enOption = page.getByRole('button', { name: /topbar-language-option-en/i }).first();
  194 |     if (await enOption.count() === 0) {
  195 |       enOption = auth.getCy('topbar-language-option-en');
  196 |     }
  197 |     await expect(enOption).toBeVisible({ timeout: 10000 });
  198 |     await enOption.click({ force: true });
  199 |     await page.waitForTimeout(2500);
  200 | 
  201 |     auth.logStep('Saving English layout screenshot: "language-en.png"');
  202 |     await page.screenshot({ path: 'cypress/screenshots/language-en.png' });
  203 | 
  204 |     const enPersisted = await page.evaluate(() => {
  205 |       const raw = window.localStorage.getItem('flutter.auth_preferred_language') || '';
  206 |       try { return JSON.parse(raw); } catch { return raw; }
  207 |     });
  208 |     expect(enPersisted).toBe('en');
  209 |     auth.logStep('✅ English locale successfully restored and persisted.');
  210 |   });
  211 | 
  212 |   test('7. Login Page Dynamic Localization Screenshot Capture', async ({ page }) => {
  213 |     auth.logStep('Executing: 7. Login Page Dynamic Localization Screenshot Capture');
  214 |     
  215 |     const selectLoginLanguage = async (lang: 'en' | 'fr' | 'es') => {
  216 |       auth.logStep(`Selecting language on login page: ${lang.toUpperCase()}`);
  217 |       
  218 |       // Target the language switcher using auth.getCy
  219 |       let switcher = auth.getCy('login-language-switcher').first();
> 220 |       await expect(switcher).toBeVisible({ timeout: 15000 });
      |                              ^ Error: expect(locator).toBeVisible() failed
  221 |       await switcher.click({ force: true });
  222 |       await page.waitForTimeout(1000);
  223 |       
  224 |       // Locate the option robustly
  225 |       let option = auth.getCy(`login-language-option-${lang}`).first();
  226 |       await expect(option).toBeVisible({ timeout: 10000 });
  227 |       await option.click({ force: true });
  228 |       
  229 |       // Allow translations asset load and UI repaint
  230 |       await page.waitForTimeout(3000);
  231 |     };
  232 | 
  233 |     // 1. Load login page in English first
  234 |     await auth.navigateToLogin();
  235 |     
  236 |     // 2. Select French and capture screenshot
  237 |     await selectLoginLanguage('fr');
  238 |     auth.logStep('Saving French Login Page screenshot: "login-page-fr.png"');
  239 |     await page.screenshot({ path: 'cypress/screenshots/login-page-fr.png' });
  240 | 
  241 |     // 3. Select English to verify transition back
  242 |     await selectLoginLanguage('en');
  243 |     await page.waitForTimeout(1000);
  244 | 
  245 |     // 4. Select Spanish and capture screenshot
  246 |     await selectLoginLanguage('es');
  247 |     auth.logStep('Saving Spanish Login Page screenshot: "login-page-es.png"');
  248 |     await page.screenshot({ path: 'cypress/screenshots/login-page-es.png' });
  249 | 
  250 |     // 5. Restore default state
  251 |     await selectLoginLanguage('en');
  252 |     auth.logStep('✅ Login page native translation screenshots successfully generated.');
  253 |   });
  254 | 
  255 |   test('8. Capture Forgot Password Dialog Visual Asset', async ({ page }) => {
  256 |     auth.logStep('Executing: 8. Capture Forgot Password Dialog Visual Asset');
  257 |     await auth.navigateToLogin();
  258 |     
  259 |     // Target and click the Forgot Password link
  260 |     const forgotPasswordLink = page.getByRole('button', { name: /Forgot Password\?/i }).first();
  261 |     await expect(forgotPasswordLink).toBeVisible({ timeout: 10000 });
  262 |     await forgotPasswordLink.click({ force: true });
  263 |     await page.waitForTimeout(2000); // Allow dialog transition
  264 | 
  265 |     auth.logStep('Saving Forgot Password Dialog screenshot: "login-forgot-password.png"');
  266 |     await page.screenshot({ path: 'cypress/screenshots/login-forgot-password.png' });
  267 |     
  268 |     // Close the dialog
  269 |     const cancelBtn = page.getByRole('button', { name: /CANCEL/i }).first();
  270 |     await expect(cancelBtn).toBeVisible({ timeout: 10000 });
  271 |     await cancelBtn.click({ force: true });
  272 |     await page.waitForTimeout(1000);
  273 |     auth.logStep('✅ Forgot Password dialog visual verification successfully captured.');
  274 |   });
  275 | });
  276 | 
```