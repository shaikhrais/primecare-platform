import { Page, expect } from '@playwright/test';

export class AuthHelper {
  readonly page: Page;
  readonly consoleErrors: string[] = [];
  readonly failedRequests: string[] = [];
  isLoggedIn: boolean = false;

  constructor(page: Page) {
    this.page = page;
    this.setupListeners();
  }

  /**
   * Generates a beautifully formatted console log for test execution steps.
   */
  logStep(step: string) {
    const timestamp = new Date().toISOString().split('T')[1].slice(0, -1);
    console.log(`\x1b[36m[PW E2E ${timestamp}]\x1b[0m 📝 ${step}`);
  }

  /**
   * Set up event listeners for console messages and failed network requests.
   */
  private setupListeners() {
    this.page.on('console', (msg) => {
      const type = msg.type();
      if (type === 'error') {
        const text = msg.text();
        if (
          !text.includes('Failed to load resource') &&
          !text.includes('favicon.ico') &&
          !text.includes('fonts.gstatic.com') &&
          !text.includes('Failed to load font')
        ) {
          this.consoleErrors.push(`[Console Error] ${text}`);
          this.logStep(`⚠️ Detected JS Console Error: "${text}"`);
        }
      }
    });

    this.page.on('pageerror', (error) => {
      this.consoleErrors.push(`[Uncaught Exception] ${error.message}`);
      this.logStep(`🚨 Uncaught JS Exception: "${error.message}"`);
    });

    this.page.on('requestfailed', (request) => {
      const url = request.url();
      const failure = request.failure();
      const errorText = failure ? failure.errorText : 'unknown error';
      
      if (
        !url.includes('favicon') &&
        !url.includes('telemetry') &&
        !url.includes('sentry') &&
        !url.includes('fonts.gstatic.com') &&
        !url.endsWith('.woff2')
      ) {
        this.failedRequests.push(`[Network Fail] URL: ${url} | Error: ${errorText}`);
        this.logStep(`❌ Network Request Failed: ${url} (${errorText})`);
      }
    });

    this.page.on('response', async (response) => {
      const url = response.url();
      const status = response.status();
      const headers = response.headers();
      const contentType = headers['content-type'] || '';
      
      if (
        contentType.includes('text/html') &&
        !url.includes('enable-semantics=true') &&
        !url.endsWith('.js') &&
        !url.endsWith('.css') &&
        !url.includes('/login') &&
        !url.includes('/dashboard') &&
        !url.includes('/offices/')
      ) {
        this.logStep(`⚠️ HTML Response detected on API/Asset URL: ${url} | Status: ${status}`);
      }
    });

    this.page.on('domcontentloaded', async () => {
      await this.injectSemanticsStyle();
    });
  }

  /**
   * Injects CSS override rules to make Flutter's invisible semantic overlays measurable and visible in Playwright.
   */
  async injectSemanticsStyle() {
    try {
      await this.page.evaluate(() => {
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
      this.logStep('✅ Injected Flutter accessibility/semantics layout override style.');
    } catch (e) {
      // Quietly ignore if frame/page context is not ready
    }
  }

  /**
   * Custom locator matching the PrimeCare Flutter semantic layer or standard HTML data-cy.
   */
  getCy(id: string) {
    return this.page.locator(`[aria-label*="data-cy:${id}"], [data-cy="${id}"]`);
  }

  /**
   * Set up API mocks for local and deployed headless verification.
   */
  async setupNetworkMocks(role: string = 'chiropractor') {
    this.logStep(`Setting up stateful E2E network mocks for role: ${role}`);
    
    // Intercept POST **/login or **/auth/login
    await this.page.route(
      '**/login',
      async (route, request) => {
        if (request.method() === 'POST') {
          this.logStep(`Intercepted POST login API request. Setting session state to logged in...`);
          this.isLoggedIn = true;
          await route.fulfill({
            status: 200,
            contentType: 'application/json',
            body: JSON.stringify({
              token: 'mock-token-exchange-success',
              user: {
                id: `${role}-user-id`,
                email: `qa.${role}@test.primecare.local`,
                roles: [role],
                tenantId: 'primecare_hq',
                firstName: 'Active',
                lastName: 'User',
              },
            }),
          });
        } else {
          await route.continue();
        }
      }
    );

    // Intercept GET **/me
    await this.page.route(
      '**/me',
      async (route) => {
        if (this.isLoggedIn) {
          this.logStep(`Intercepted GET /me API request (Authenticated). Replying with mock profile...`);
          await route.fulfill({
            status: 200,
            contentType: 'application/json',
            body: JSON.stringify({
              status: 'success',
              userId: `${role}-user-id`,
              email: `qa.${role}@test.primecare.local`,
              roles: [role],
              tenantId: 'primecare_hq',
              firstName: 'Active',
              lastName: 'User',
            }),
          });
        } else {
          this.logStep(`Intercepted GET /me API request (Unauthenticated). Replying with 401 Unauthorized...`);
          await route.fulfill({
            status: 401,
            contentType: 'application/json',
            body: JSON.stringify({
              status: 'fail',
              message: 'Unauthorized',
            }),
          });
        }
      }
    );

    // Intercept POST/PUT/GET **/preferences or **/user/preferences
    await this.page.route(
      '**/preferences',
      async (route) => {
        this.logStep(`Intercepted user preferences API request. Replying with success...`);
        await route.fulfill({
          status: 200,
          contentType: 'application/json',
          body: JSON.stringify({
            status: 'success',
            message: 'Preferences updated successfully',
          }),
        });
      }
    );
  }

  /**
   * Navigates to the login page and asserts its visibility.
   */
  async navigateToLogin() {
    // Automatically register E2E network mocks before navigating
    await this.setupNetworkMocks();

    this.logStep('Navigating to PrimeCare Clinic login page with semantic mode enabled...');
    await this.page.goto('/login?enable-semantics=true');
    
    await this.page.waitForLoadState('domcontentloaded');
    this.logStep('Waiting 4s for Flutter engine bootstrapping...');
    await this.page.waitForTimeout(4000);
    await this.injectSemanticsStyle();
    this.logStep('Login page loaded. Verifying form visibility...');
    
    const emailField = this.getCy('login-email');
    await expect(emailField).toBeVisible({ timeout: 15000 });
  }

  async login(email?: string, password?: string) {
    const targetEmail = email || process.env.TEST_EMAIL || 'qa.chiropractor@test.primecare.local';
    const targetPassword = password || process.env.TEST_PASSWORD || 'Test@12345';

    let role = 'chiropractor';
    if (targetEmail.includes('chiropractor')) role = 'chiropractor';
    else if (targetEmail.includes('admin')) role = 'admin';
    else if (targetEmail.includes('physio')) role = 'physio';
    else if (targetEmail.includes('rmt')) role = 'rmt';

    let postLoginRoute = '/offices/clinical/roles/chiropractor/dashboard';
    if (role === 'admin') postLoginRoute = '/common/office-dashboard';

    this.logStep(`Directly seeding authenticated session for role: ${role}`);
    
    // Inject auth variables into local storage and session storage on boot
    await this.page.addInitScript(({ r }) => {
      window.localStorage.setItem('flutter.auth_token', JSON.stringify('mock-token-exchange-success'));
      window.localStorage.setItem('flutter.auth_role', JSON.stringify(r));
      window.localStorage.setItem('flutter.auth_tenant_id', JSON.stringify('primecare_hq'));
      window.localStorage.setItem('flutter.auth_username', JSON.stringify('Active User'));
      window.localStorage.setItem('flutter.auth_user_id', JSON.stringify(`${r}-user-id`));
      window.localStorage.setItem('flutter.auth_preferred_language', 'en');

      window.sessionStorage.setItem('flutter.auth_token', JSON.stringify('mock-token-exchange-success'));
      window.sessionStorage.setItem('flutter.auth_role', JSON.stringify(r));
      
      // Inject cookie
      document.cookie = `session_token=mock-token-exchange-success; path=/;`;
    }, { r: role });

    // Set network mocks and update state
    await this.setupNetworkMocks(role);
    this.isLoggedIn = true;

    // Navigate straight to protected route
    const targetUrl = `${postLoginRoute}?enable-semantics=true`;
    this.logStep(`Navigating to landing dashboard: ${targetUrl}`);
    await this.page.goto(targetUrl);
    
    await this.page.waitForLoadState('domcontentloaded');
    this.logStep('Waiting 4s for Flutter engine bootstrapping...');
    await this.page.waitForTimeout(4000);
    await this.injectSemanticsStyle();
  }

  /**
   * Verifies that the app shell and clinic dashboard are loaded.
   */
  async verifyDashboard() {
    this.logStep('Waiting for dynamic redirect away from login page...');
    await this.page.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 25000 });
    
    this.logStep('URL redirect complete. Waiting 4s for Flutter engine to bootstrap...');
    await this.page.waitForTimeout(4000);
    await this.injectSemanticsStyle();
    this.logStep('Verifying shell layout elements...');

    const shell = this.getCy('app-shell');
    const topbar = this.getCy('app-topbar');
    const sidebar = this.getCy('app-sidebar');
    const content = this.getCy('app-content-slot');

    await expect(shell).toBeVisible({ timeout: 20000 });
    await expect(topbar).toBeVisible();
    await expect(sidebar).toBeVisible();
    await expect(content).toBeVisible();

    this.logStep('App Shell components loaded successfully. Dashboard is active.');
  }

  /**
   * Performs logout and verifies session destruction.
   */
  async logout() {
    this.logStep('Initiating logout sequence...');
    this.isLoggedIn = false; // Reset the session state back to logged out!
    
    // Support both the PopupMenuButton ('User Functions') and the raw trailing IconButton (represented as the last button in the topbar)
    const profileMenu = this.page.locator('[aria-label*="User Functions"], [aria-label*="user-menu"], [aria-label*="profile"], [data-cy="user-menu-button"]');
    
    if (await profileMenu.count() > 0) {
      this.logStep('Clicking user profile dropdown...');
      await profileMenu.click({ force: true });
      
      this.logStep('Waiting 1s for dropdown popup to settle...');
      await this.page.waitForTimeout(1000);

      this.logStep('Clicking Sign Out button...');
      const logoutBtn = this.page.locator('[aria-label*="Sign Out"], [aria-label*="Logout"], [data-cy="logout-button"], text=/Sign Out|Logout/i');
      await logoutBtn.click({ force: true });
    } else {
      this.logStep('User Functions dropdown not present. Targeting trailing topbar action button (raw IconButton)...');
      const topbar = this.getCy('app-topbar');
      const logoutIconBtn = topbar.locator('flt-semantics[role="button"]').last();
      await logoutIconBtn.click({ force: true });
    }

    this.logStep('Clearing browser local storage, session storage, and cookies...');
    await this.page.evaluate(() => {
      window.localStorage.clear();
      window.sessionStorage.clear();
      document.cookie.split(";").forEach((c) => {
        document.cookie = c
          .replace(/^ +/, "")
          .replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/");
      });
    });

    this.logStep('Verifying redirection back to the login gateway...');
    await this.page.waitForURL((url) => url.pathname.includes('/login'), { timeout: 15000 });
    
    const emailField = this.getCy('login-email');
    await expect(emailField).toBeVisible({ timeout: 10000 });
    this.logStep('Redirection complete. Session closed.');
  }

  /**
   * Asserts that no console errors or network failure occurrences were captured.
   */
  assertZeroFailures() {
    this.logStep('Validating runtime console and network logs...');
    expect(this.consoleErrors, `Found JS Console Errors:\n${this.consoleErrors.join('\n')}`).toHaveLength(0);
    expect(this.failedRequests, `Found Failed Network Requests:\n${this.failedRequests.join('\n')}`).toHaveLength(0);
    this.logStep('✅ Runtime logs integrity verified: 0 errors, 0 failed requests.');
  }
}
