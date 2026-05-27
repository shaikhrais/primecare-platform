Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[aria-label*="data-cy:${id}"], [data-cy="${id}"]`, {
    includeShadowDom: true,
  });
});

Cypress.Commands.add("waitAndSee", () => {
  cy.wait(2000);
});

Cypress.Commands.add("visitWithSemantics", (path) => {
  if (path.startsWith("/#/")) {
    const hashSegment = path.substring(2); // e.g. "/login"
    const delimiter = hashSegment.includes("?") ? "&" : "?";
    return cy.visit(`/?enable-semantics=true#${hashSegment}`);
  } else if (path.startsWith("#/")) {
    const hashSegment = path.substring(1);
    return cy.visit(`/?enable-semantics=true#${hashSegment}`);
  }
  const querySymbol = path.includes("?") ? "&" : "?";
  return cy.visit(`${path}${querySymbol}enable-semantics=true`);
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

    // Visit login with semantics parameter
    cy.visit("/login?enable-semantics=true");
    cy.wait(2000);

    // Support both input[type="text"] and input[type="email"] for robust targeting
    cy.get('input[type="text"], input[type="email"]', { includeShadowDom: true })
      .first()
      .should("be.visible")
      .clear()
      .type(user.email);

    cy.get('input[type="password"]', { includeShadowDom: true })
      .should("be.visible")
      .clear()
      .type(password, { log: false });

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
