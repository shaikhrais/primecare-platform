Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[aria-label*="data-cy:${id}"], [data-cy="${id}"]`, {
    includeShadowDom: true,
  });
});

Cypress.Commands.add("waitAndSee", () => {
  cy.wait(2000);
});

Cypress.Commands.add("visitWithSemantics", (path) => {
  // Extract clean path without leading slash if present
  const cleanPath = path.startsWith("/") ? path.substring(1) : path;
  
  cy.window().then((win) => {
    const hasShell = win.document.querySelector('[aria-label*="data-cy:app-shell"], [data-cy="app-shell"]');
    if (hasShell) {
      // SPA client-side transition to prevent page reload session loss
      cy.log(`Client-side hash transition to: ${path}`);
      win.location.hash = `#/${cleanPath}`;
      cy.wait(1000);
    } else {
      // Fallback for initial load
      const querySymbol = path.includes("?") ? "&" : "?";
      cy.visit(`${path}${querySymbol}enable-semantics=true`);
    }
  });
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

    // Intercept background session restoration checks on SSO portal to prevent auto-login race conditions.
    cy.intercept("GET", "**/me", (req) => {
      let hasToken = false;
      let isAuthPortal = false;
      let pathname = "/";
      
      try {
        const win = Cypress.state('window');
        if (win) {
          const currentUrl = new URL(win.location.href);
          hasToken = currentUrl.searchParams.has("token");
          pathname = currentUrl.pathname;
          isAuthPortal = currentUrl.hostname.includes("primecare-auth");
        }
      } catch (_) {}

      // Fallback to headers if window is not ready
      if (!hasToken) {
        try {
          const referer = req.headers.referer || req.headers.origin || "";
          const refUrl = new URL(referer);
          hasToken = refUrl.searchParams.has("token");
          isAuthPortal = isAuthPortal || refUrl.hostname.includes("primecare-auth");
        } catch (_) {}
      }

      const isInitialLoad = !hasToken && (
        pathname === "/" || 
        pathname.includes("/login") || 
        pathname.includes("/sso-redirect") || 
        isAuthPortal
      );

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

    // Visit the protected dashboard route of the primary application first to establish correct top origin context
    cy.visit(user.app_url + "/?enable-semantics=true#" + user.post_login_route);
    cy.wait(4000);

    // Expect redirect to sso portal / login page
    cy.url().should("include", "primecare-auth");

    // Perform SSO authentication dynamically inside cy.origin block
    cy.origin("https://primecare-auth.pages.dev", { args: { user, password } }, ({ user, password }) => {
      // Force clear all storage to prevent session bleeding
      cy.clearCookies();
      cy.clearLocalStorage();

      // Ensure we are on the login view by checking the active path
      cy.window().then((win) => {
        try {
          win.sessionStorage.clear();
        } catch (_) {}
        if (!win.location.pathname.includes("/login")) {
          cy.log("SSO Portal: Bypassing stale session and navigating to clean login page...");
          win.location.href = `/login?redirect_uri=${encodeURIComponent(user.redirect_url)}`;
          cy.wait(3000);
        }
      });

      // Wait for page/DOM to load and check if the login form is present
      cy.document().then((doc) => {
        const hasLoginForm = doc.querySelector('input[type="password"]');
        if (hasLoginForm) {
          cy.log("SSO Portal: User is not authenticated. Performing active session login...");
          
          // Enter credentials
          cy.get('input[type="text"], input[type="email"]', { includeShadowDom: true })
            .first()
            .should("be.visible")
            .clear({ force: true });
            
          const resolvedEmail = user.email.endsWith(".local") ? `${user.email}.com` : user.email;
          cy.get('input[type="text"], input[type="email"]', { includeShadowDom: true })
            .first()
            .type(resolvedEmail, { force: true });

          cy.get('input[type="password"]', { includeShadowDom: true })
            .should("be.visible")
            .clear({ force: true });
            
          cy.get('input[type="password"]', { includeShadowDom: true })
            .type(password, { log: false, force: true });

          // Take screenshot of filled login
          cy.screenshot(`auth-login-${user.role_code}`);

          // Click Initiate Session
          const hasInitiateSession = doc.body.innerText.includes("INITIATE SESSION");
          if (hasInitiateSession) {
            cy.contains("INITIATE SESSION", { includeShadowDom: true }).click({ force: true });
          } else {
            cy.get('button, input[type="submit"]', { includeShadowDom: true }).first().click({ force: true });
          }
          
          cy.wait(4000);
        } else {
          cy.log("SSO Portal: User is already authenticated. Bypassing login credentials...");
        }
      });

      // Assert and click the Consent approve button
      cy.contains("Approve & Continue", { includeShadowDom: true, timeout: 20000 })
        .should("be.visible")
        .click({ force: true });
        
      cy.wait(3000);
    });

    // Back to primary app origin context! Assert redirection is complete.
    cy.url().should("include", user.app_url);
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
