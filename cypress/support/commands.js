Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[aria-label*="data-cy:${id}"], [data-cy="${id}"]`, {
    includeShadowDom: true,
  });
});

Cypress.Commands.add("waitAndSee", () => {
  cy.wait(2000);
});

Cypress.Commands.add("visitWithSemantics", (path) => {
  const querySymbol = path.includes("?") ? "&" : "?";
  cy.visit(`${path}${querySymbol}enable-semantics=true`);
  cy.wait(1500);
});

Cypress.Commands.add("verifyNotBlank", () => {
  cy.get("body").should("be.visible");
  cy.get("body").invoke("text").then((text) => {
    if (!text || text.trim().length < 5) {
      throw new Error("Page body text is empty or too small. Possible blank render.");
    }
  });
});

Cypress.Commands.add("verifyShellExists", () => {
  cy.getCy('app-shell').should("be.visible");
  cy.getCy('app-topbar').should("be.visible");
  cy.getCy('app-sidebar').should("be.visible");
  cy.getCy('app-content-slot').should("be.visible");
});

Cypress.Commands.add("loginAsRole", (roleCode) => {
  cy.clearAllCookies();
  cy.clearAllLocalStorage();
  cy.clearAllSessionStorage();

  cy.fixture("governance/test_users.json").then((users) => {
    const user = users.find((u) => u.role_code === roleCode);
    if (!user) throw new Error(`No test user for role ${roleCode}`);

    const password = user.password || "Test@12345";
    const targetBaseUrl = user.app_url; // Always use the deployed Cloudflare app URL!

    // Intercept background session restoration checks on SSO portal to prevent auto-login race conditions.
    cy.intercept("GET", "**/me", (req) => {
      const authHeader = req.headers.authorization || req.headers.Authorization || "";
      const hasTokenInHeader = authHeader.startsWith("Bearer ") && authHeader.substring(7).trim().length > 0;
      
      let hasToken = hasTokenInHeader;
      let isAuthPortal = false;
      let pathname = "/";
      
      try {
        const win = Cypress.state('window');
        if (win) {
          const currentUrl = new URL(win.location.href);
          hasToken = hasToken || currentUrl.searchParams.has("token") || currentUrl.hash.includes("token");
          pathname = currentUrl.pathname;
          isAuthPortal = currentUrl.hostname.includes("primecare-auth");
        }
      } catch (_) {}

      // Fallback using referer header if window context is not fully ready
      if (!hasToken || pathname === "/") {
        try {
          const referer = req.headers.referer || req.headers.origin || "";
          if (referer) {
            const refUrl = new URL(referer);
            hasToken = hasToken || refUrl.searchParams.has("token") || refUrl.hash.includes("token") || refUrl.search.includes("token");
            pathname = refUrl.pathname;
            isAuthPortal = isAuthPortal || refUrl.hostname.includes("primecare-auth");
          }
        } catch (_) {}
      }

      const isInitialLoad = !hasToken;

      if (isInitialLoad) {
        req.reply({
          statusCode: 401,
          body: { status: "error", message: "Unauthorized" }
        });
      } else {
        req.reply({
          statusCode: 200,
          body: {
            status: "success",
            userId: user.role_code + "-user-id",
            email: user.email,
            roles: [user.role_code],
            tenantId: "primecare_hq",
            firstName: "Active",
            lastName: "User"
          }
        });
      }
    }).as("ssoHandshake");

    const cleanPostLoginRoute = user.post_login_route.startsWith("/")
      ? user.post_login_route.substring(1)
      : user.post_login_route;

    // Visit the protected dashboard route first to establish top origin context
    cy.visit(targetBaseUrl + user.post_login_route + "?enable-semantics=true", {
      onBeforeLoad(win) {
        cy.stub(win, "open").callsFake((url) => {
          win.location.href = url;
        });
      }
    });
    cy.wait(4000);

    // Perform SSO authentication dynamically inside cy.origin block
    cy.origin("https://primecare-auth.pages.dev", { args: { user, password } }, ({ user, password }) => {
      // Force clear all storage to prevent session bleeding
      cy.clearCookies();
      cy.clearLocalStorage();

      // Wiping IndexedDB to fully clear any persistent SharedPreferences/Hive session states in Flutter
      cy.window().then((win) => {
        try {
          win.sessionStorage.clear();
        } catch (_) {}
        try {
          win.indexedDB.databases().then((dbs) => {
            dbs.forEach((db) => {
              if (db.name) win.indexedDB.deleteDatabase(db.name);
            });
          });
        } catch (_) {}
      });

      // Use native Cypress visit to cleanly navigate and wait for the page load!
      cy.visit(`/login?force_login=true&redirect_uri=${encodeURIComponent(user.redirect_url)}`);
      
      // Wait for Flutter app to fully mount and render UI elements
      cy.contains("Authorized Access", { includeShadowDom: true, timeout: 20000 }).should("be.visible");
      cy.wait(2000);

      const resolvedEmail = user.email;

      // Enter credentials
      cy.get('input[type="text"], input[type="email"]', { includeShadowDom: true })
        .first()
        .should("be.visible")
        .clear({ force: true })
        .type(resolvedEmail, { force: true });

      cy.get('input[type="password"]', { includeShadowDom: true })
        .should("be.visible")
        .clear({ force: true })
        .type(password, { log: false, force: true });

      // Take screenshot of filled login
      cy.screenshot(`auth-login-${user.role_code}`);

      // Click Initiate Session
      cy.get("body", { includeShadowDom: true }).then(($body) => {
        const hasInitiateSession = $body.text().includes("INITIATE SESSION");
        if (hasInitiateSession) {
          cy.log("SSO Portal: Clicking semantic INITIATE SESSION button...");
          cy.contains("INITIATE SESSION", { includeShadowDom: true }).click({ force: true });
        } else {
          cy.log("SSO Portal: Clicking fallback submit button...");
          cy.get('button, input[type="submit"]', { includeShadowDom: true }).first().click({ force: true });
        }
      });
      
      cy.wait(5000);

      // Assert and click the Consent approve button
      cy.contains("Approve & Continue", { includeShadowDom: true, timeout: 20000 })
        .should("be.visible")
        .click({ force: true });
        
      cy.wait(4000); // Allow browser to start transition and change origin back
    });

    // Back to primary app origin context! Assert redirection is complete.
    cy.url({ timeout: 45000 }).should("not.include", "primecare-auth.pages.dev");
    cy.wait(6000); // Remaining delay to let the clinic portal process the deep link callback
    cy.wait(2000);

    // Verify dynamic sidebar, topbar, and shell rendering
    cy.get('[aria-label*="data-cy:app-shell"], [data-cy="app-shell"]', { includeShadowDom: true, timeout: 15000 })
      .should("be.visible");
    cy.get('[aria-label*="data-cy:app-topbar"], [data-cy="app-topbar"]', { includeShadowDom: true })
      .should("be.visible");
    cy.get('[aria-label*="data-cy:app-sidebar"], [data-cy="app-sidebar"]', { includeShadowDom: true })
      .should("be.visible");
    cy.get('[aria-label*="data-cy:app-content-slot"], [data-cy="app-content-slot"]', { includeShadowDom: true })
      .should("be.visible");
      
    // Assert correct landing route
    cy.url().should("include", user.post_login_route);
  });
});

Cypress.Commands.add("switchLanguage", (locale) => {
  cy.getCy('topbar-language-switcher').should("be.visible").click({ force: true });
  cy.waitAndSee();
  cy.getCy(`topbar-language-option-${locale}`).should("be.visible").click({ force: true });
  cy.waitAndSee();
  cy.verifyNotBlank();
});
