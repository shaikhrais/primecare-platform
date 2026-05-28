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
  cy.fixture("governance/test_users.json").then((users) => {
    const user = users.find((u) => u.role_code === roleCode);
    if (!user) throw new Error(`No test user for role ${roleCode}`);

    const password = Cypress.env(user.password_env);
    if (!password) throw new Error(`Missing Cypress env password: ${user.password_env}`);

    // Intercept only the first silent SSO session restoration check on load to prevent auto-login redirection
    cy.intercept({
      method: "GET",
      url: "**/me",
      times: 1
    }, {
      statusCode: 401,
      body: { status: "error", message: "Unauthorized" }
    }).as("ssoHandshake");

    // First visit to establish origin context in Cypress with pathname /
    cy.visit("/?enable-semantics=true#/login");
    cy.wait(1000);
    
    // Clear all storage for the origin (clearing SharedPreferences)
    cy.clearLocalStorage();
    cy.clearCookies();
    
    // Re-visit to force rendering a clean form with pathname /
    cy.visit("/?enable-semantics=true#/login");
    cy.wait(2000);

    // Support both input[type="text"] and input[type="email"] for robust targeting
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

    // Handle "INITIATE SESSION" click with fallback to generic submit if needed
    cy.document().then((doc) => {
      const hasInitiateSession = doc.body.innerText.includes("INITIATE SESSION");
      if (hasInitiateSession) {
        cy.contains("INITIATE SESSION", { includeShadowDom: true }).click({ force: true });
      } else {
        // Fallback for standard buttons or elements
        cy.get('button, input[type="submit"]', { includeShadowDom: true }).first().click({ force: true });
      }
    });

    cy.wait(2000);
    cy.get("body").invoke("text").should((text) => {
      expect(text.trim().length).to.be.greaterThan(5);
    });

    cy.screenshot(`auth-login-${roleCode}`);
  });
});

Cypress.Commands.add("switchLanguage", (locale) => {
  cy.getCy('topbar-language-switcher').should("be.visible").click({ force: true });
  cy.waitAndSee();
  cy.getCy(`topbar-language-option-${locale}`).should("be.visible").click({ force: true });
  cy.waitAndSee();
  cy.verifyNotBlank();
});
