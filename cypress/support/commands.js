Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[aria-label="data-cy:${id}"], [data-cy="${id}"]`, {
    includeShadowDom: true,
  });
});

Cypress.Commands.add("waitAndSee", () => {
  cy.wait(2000);
});

Cypress.Commands.add("visitWithSemantics", (path) => {
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

    if (!user) {
      throw new Error(`No test user found for role ${roleCode}`);
    }

    cy.visitWithSemantics("/#/login");
    cy.waitAndSee();

    cy.getCy("login-email").should("be.visible").clear().type(user.email);
    cy.getCy("login-password").should("be.visible").clear().type(user.password, { log: false });
    cy.getCy("login-submit").should("be.visible").click({ force: true });

    cy.waitAndSee();

    cy.verifyNotBlank();
    cy.url().then((url) => {
      if (url.includes("/success")) {
        cy.contains("Authentication Successful").should("be.visible");
      }
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
