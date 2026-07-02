declare global {
  namespace Cypress {
    interface Chainable {
      loginAsRole(roleCode: string): Chainable<void>;
      assertLoginSuccessful(roleCode: string): Chainable<void>;
      verifyRequiredElements(elements: Array<{ selector: string; required: boolean }>): Chainable<void>;
      verifyForbiddenText(forbiddenText: string[]): Chainable<void>;
      verifyNoConsoleErrors(): Chainable<void>;
      verifyScreenNotEmpty(): Chainable<void>;
      verifyRoleSidebar(roleCode: string, expectedLinks: string[]): Chainable<void>;
      recordDbTestResult(result: {
        test_definition_id: number;
        screen_id: number;
        run_id: string;
        status: string;
        error_message: string | null;
        screenshot_path: string | null;
        video_path: string | null;
        browser: string;
        started_at: string;
        finished_at: string;
        duration_ms: number;
      }): Chainable<any>;
    }
  }
}

// 1. Verify required elements are visible on the page
Cypress.Commands.add("verifyRequiredElements", (elements) => {
  elements.forEach((elem) => {
    if (elem.required) {
      cy.task("log", `Checking required element: ${elem.selector}`);
      cy.getCy(elem.selector).should("be.visible");
    }
  });
});

// 2. Verify page body text does not contain any forbidden terms
Cypress.Commands.add("verifyForbiddenText", (forbiddenText) => {
  cy.get("body").should("be.visible").invoke("text").then((text) => {
    forbiddenText.forEach((phrase) => {
      expect(text).to.not.contain(phrase);
    });
  });
});

// 3. Verify no browser console errors occurred
Cypress.Commands.add("verifyNoConsoleErrors", () => {
  cy.window().then((win: any) => {
    if (win.top && win.top.browserLogs) {
      const errors = win.top.browserLogs.filter((log: string) => log.startsWith("[BROWSER ERROR]"));
      if (errors.length > 0) {
        throw new Error(`Console errors detected during execution:\n${errors.join("\n")}`);
      }
    }
  });
});

// 4. Verify main content area is not empty or filled with placeholder text
Cypress.Commands.add("verifyScreenNotEmpty", () => {
  cy.get('[data-testid="main-content"], [data-cy="app-content-slot"], [aria-label*="data-cy:app-content-slot"], [aria-label*="app-content-slot"]', { includeShadowDom: true, timeout: 5000 })
    .first()
    .then(($el) => {
      // Check main content height is greater than 300px
      const height = $el[0].offsetHeight || $el[0].clientHeight || 0;
      if (height > 0 && height < 300) {
        throw new Error(`EMPTY_SCREEN: Main content height (${height}px) is less than 300px`);
      }
      
      // Count visible descendants: at least 3 visible descendants
      const descendants = $el.find('flt-semantics, div, button, input');
      const visibleDescendants = descendants.filter((i, el) => {
        const rect = el.getBoundingClientRect();
        return rect.width > 0 && rect.height > 0;
      });
      if (visibleDescendants.length < 3) {
        throw new Error(`EMPTY_SCREEN: Main content has only ${visibleDescendants.length} visible elements (minimum 3 required)`);
      }
      
      // Check text length: text length > 80 characters
      const text = $el.text().trim();
      if (text.length <= 80) {
        throw new Error(`EMPTY_SCREEN: Main content text length (${text.length} chars) is 80 or less`);
      }
      
      // Check whitespace
      if (/^\s*$/.test(text)) {
        throw new Error("EMPTY_SCREEN: Main content is only whitespace");
      }
      
      // Check placeholder empty state
      const forbiddenPhrases = [
        "Fully Implemented",
        "Placeholder",
        "Coming Soon",
        "TODO",
        "Lorem ipsum",
        "Under Construction",
        "Sample Data",
        "Screen Implemented"
      ];
      for (const phrase of forbiddenPhrases) {
        if (text === phrase || (text.toLowerCase().includes(phrase.toLowerCase()) && text.length < 150)) {
          throw new Error(`PLACEHOLDER_ONLY: Main content contains forbidden/placeholder text: "${phrase}"`);
        }
      }
      
      // Check at least one of: button, input, table, form, card, list, chart, textarea, select
      let hasInteractive = false;
      const interactiveSelectors = [
        'button', 'input', 'table', 'form', 'textarea', 'select',
        '[role="button"]', '[role="text-field"]', '[role="checkbox"]',
        '[aria-label*="btn"]', '[aria-label*="button"]', '[aria-label*="input"]',
        '[aria-label*="card"]', '[aria-label*="chart"]', '[aria-label*="table"]',
        '[data-cy*="btn"]', '[data-cy*="button"]', '[data-cy*="input"]',
        '[data-cy*="card"]', '[data-cy*="chart"]', '[data-cy*="table"]'
      ];
      for (const sel of interactiveSelectors) {
        if ($el.find(sel).length > 0) {
          hasInteractive = true;
          break;
        }
      }
      
      if (!hasInteractive) {
        visibleDescendants.each((i, el) => {
          const label = el.getAttribute('aria-label') || '';
          const textLower = el.textContent?.toLowerCase() || '';
          if (
            label.includes('btn') || label.includes('button') || label.includes('input') ||
            label.includes('card') || label.includes('chart') || label.includes('table') ||
            label.includes('field') || label.includes('form') || label.includes('select') ||
            textLower.includes('submit') || textLower.includes('save') || textLower.includes('search')
          ) {
            hasInteractive = true;
            return false;
          }
        });
      }
      
      if (!hasInteractive) {
        throw new Error("EMPTY_SCREEN: Main content has no interactive or structured elements (buttons, inputs, cards, tables, etc.)");
      }
    });
});

Cypress.Commands.add("verifyRoleSidebar", (roleCode, expectedLinks) => {
  cy.getCy('app-sidebar').should('be.visible');
  
  cy.getCy('app-sidebar').then((sidebar) => {
    const buttons = sidebar.find('flt-semantics[role="button"], flt-semantics[aria-label*="data-cy:sidebar-nav-"]');
    const actualLinks: string[] = [];
    buttons.each((i, el) => {
      let text = el.textContent?.trim() || '';
      const label = el.getAttribute('aria-label') || '';
      if (!text && label.includes('data-cy:sidebar-nav-')) {
        text = label.split('data-cy:sidebar-nav-')[1].replace(/-/g, ' ');
      } else if (!text) {
        text = label;
      }
      if (text) {
        actualLinks.push(text);
      }
    });
    
    cy.log(`Actual sidebar links found: ${JSON.stringify(actualLinks)}`);
    
    if (buttons.length === 0) {
      throw new Error("MISSING_SIDEBAR_LINK: Sidebar contains zero links");
    }
    
    const nonGenericLinks = actualLinks.filter(link => {
      const l = link.toLowerCase();
      return !l.includes('home') && !l.includes('profile') && !l.includes('logout') && !l.includes('dashboard');
    });
    
    if (nonGenericLinks.length === 0 && expectedLinks.length > 0) {
      throw new Error("MISSING_SIDEBAR_LINK: Sidebar only contains generic links (home/profile/logout)");
    }
    
    for (const expected of expectedLinks) {
      let cleanExpected = expected;
      const prefixes = ["ceo", "rmt", "ciso", "psw", "rn", "physician", "clinical director", "coo", "cfo", "cto", "qa", "hsw", "np", "rpn", "lpn"];
      for (const p of prefixes) {
        if (cleanExpected.toLowerCase().startsWith(p + " ")) {
          cleanExpected = cleanExpected.substring(p.length + 1).trim();
          break;
        }
      }

      const found = actualLinks.some(actual => 
        actual.toLowerCase().includes(cleanExpected.toLowerCase()) || 
        cleanExpected.toLowerCase().includes(actual.toLowerCase())
      );
      if (!found) {
        throw new Error(`MISSING_SIDEBAR_LINK: Expected sidebar link "${cleanExpected}" (original: "${expected}") is missing`);
      }
    }
    
    // Click every sidebar link and verify route opens
    const count = buttons.length;
    for (let i = 0; i < count; i++) {
      cy.getCy('app-sidebar').then((currentSidebar) => {
        const currentButtons = currentSidebar.find('flt-semantics[role="button"], flt-semantics[aria-label*="data-cy:sidebar-nav-"]');
        const $btn = currentButtons.eq(i);
        const labelText = $btn.text().trim() || $btn.attr('aria-label') || `item_${i}`;
        cy.log(`Clicking sidebar item: ${labelText}`);
        cy.wrap($btn).click({ force: true });
        cy.wait(3000);
        cy.verifyScreenNotEmpty();
      });
    }
  });
});

// 6. Record test execution details directly into governance.db and log screen issues
Cypress.Commands.add("recordDbTestResult", (res) => {
  const query = `
    INSERT INTO screen_test_results (
      test_definition_id, screen_id, run_id, status, error_message, 
      screenshot_path, video_path, browser, started_at, finished_at, duration_ms
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;
  const params = [
    res.test_definition_id,
    res.screen_id,
    res.run_id,
    res.status,
    res.error_message,
    res.screenshot_path,
    res.video_path,
    res.browser,
    res.started_at,
    res.finished_at,
    res.duration_ms
  ];
  
  return cy.task("queryDb", { query, params }).then((insertResult: any) => {
    const resultIdQuery = "SELECT last_insert_rowid() as id";
    return cy.task("queryDb", { query: resultIdQuery, params: [] }).then((idRows: any) => {
      const testResultId = idRows && idRows.length > 0 ? idRows[0].id : null;
      
      const passed = res.status === "passed";
      
      // Determine verification values
      const route_loaded = (res.error_message && res.error_message.includes("check_url")) ? 0 : 1;
      const sidebar_found = (res.error_message && (res.error_message.includes("verify_sidebar_exists") || res.error_message.includes("MISSING_SIDEBAR_LINK"))) ? 0 : 1;
      const topbar_found = (res.error_message && res.error_message.includes("verify_topbar_exists")) ? 0 : 1;
      const main_content_found = (res.error_message && res.error_message.includes("verify_main_content_exists")) ? 0 : 1;
      const placeholder_found = (res.error_message && (res.error_message.includes("EMPTY_SCREEN") || res.error_message.includes("PLACEHOLDER_ONLY"))) ? 1 : 0;
      const verified_at = new Date().toISOString();

      // Clear existing verification for this screen
      cy.task("queryDb", { query: "DELETE FROM screen_verification WHERE screen_id = ?", params: [res.screen_id] });
      
      // Insert new screen_verification record
      const insertVerifQuery = `
        INSERT INTO screen_verification (screen_id, route_loaded, sidebar_found, topbar_found, main_content_found, placeholder_found, screenshot_path, verified_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `;
      cy.task("queryDb", { 
        query: insertVerifQuery, 
        params: [res.screen_id, route_loaded, sidebar_found, topbar_found, main_content_found, placeholder_found, res.screenshot_path || null, verified_at] 
      });

      if (passed) {
        // Update screens to set verified
        const updateScreensQuery = `
          UPDATE screens
          SET runtime_verified = 1, cypress_verified = 1
          WHERE id = ?
        `;
        cy.task("queryDb", { query: updateScreensQuery, params: [res.screen_id] });
      } else {
        // Update screens to fail verification status
        const updateScreensQuery = `
          UPDATE screens
          SET runtime_verified = 0, cypress_verified = 0, production_ready = 0
          WHERE id = ?
        `;
        cy.task("queryDb", { query: updateScreensQuery, params: [res.screen_id] });
        
        // Log issue
        let issueType = "runtime_error";
        let severity = "critical";
        let desc = res.error_message || "Unknown E2E runtime error";
        
        if (res.error_message) {
          if (res.error_message.includes("EMPTY_SCREEN")) {
            issueType = "empty_screen";
          } else if (res.error_message.includes("PLACEHOLDER_ONLY")) {
            issueType = "placeholder_only";
          } else if (res.error_message.includes("MISSING_SIDEBAR_LINK")) {
            issueType = "missing_sidebar_link";
          }
        }
        
        const insertIssueQuery = `
          INSERT INTO screen_issues (screen_id, test_result_id, issue_type, severity, description, fixed)
          VALUES (?, ?, ?, ?, ?, 0)
        `;
        cy.task("queryDb", { query: insertIssueQuery, params: [res.screen_id, testResultId, issueType, severity, desc] });
      }
      return cy.wrap(insertResult);
    });
  });
});

Cypress.Commands.add("assertLoginSuccessful", (roleCode) => {
  cy.url().should("not.include", "/login");
  
  cy.window().then((win) => {
    let hasToken = false;
    for (let i = 0; i < win.localStorage.length; i++) {
      const key = win.localStorage.key(i);
      if (key && (key.includes("token") || key.includes("auth"))) {
        hasToken = true;
        break;
      }
    }
    if (!hasToken) {
      for (let i = 0; i < win.sessionStorage.length; i++) {
        const key = win.sessionStorage.key(i);
        if (key && (key.includes("token") || key.includes("auth"))) {
          hasToken = true;
          break;
        }
      }
    }
    expect(hasToken, "Authentication token or session must exist in storage").to.be.true;
  });

  cy.getCy('app-sidebar').should('be.visible');
  cy.getCy('app-sidebar').find('flt-semantics[role="button"], flt-semantics[aria-label*="data-cy:sidebar-nav-"]').should('have.length.greaterThan', 0);
  cy.getCy('app-topbar').should('be.visible');
  cy.getCy('app-content-slot').should('be.visible');

  cy.get('body').then(($body) => {
    if ($body.find('[aria-label*="login-email"], [data-cy="login-email"]').length > 0) {
      throw new Error("LOGIN_FAILED: Login email field is still visible on the page.");
    }
    if ($body.find('[aria-label*="login-submit"], [data-cy="login-submit"]').length > 0) {
      throw new Error("LOGIN_FAILED: Login submit button is still visible on the page.");
    }
  });

  cy.get("body").invoke("text").then((text) => {
    if (text.includes("Sign In to PrimeCare") || text.includes("Welcome Back")) {
      throw new Error("LOGIN_FAILED: Page text contains login headers. SSO login did not succeed.");
    }
  });
});

export {};
