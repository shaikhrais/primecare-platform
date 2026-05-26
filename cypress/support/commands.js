Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[data-cy="${id}"]`);
});

Cypress.Commands.add("waitAndSee", () => {
  cy.wait(2000);
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
  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
});

Cypress.Commands.add("loginAsRole", (roleCode) => {
  cy.fixture("governance/test_users.json").then((users) => {
    const user = users.find((u) => u.role_code === roleCode);

    if (!user) {
      throw new Error(`No test user found for role ${roleCode}`);
    }

    cy.visit("/login");
    cy.waitAndSee();

    cy.get('[data-cy="login-email"]').should("be.visible").clear().type(user.email);
    cy.get('[data-cy="login-password"]').should("be.visible").clear().type(user.password, { log: false });
    cy.get('[data-cy="login-submit"]').should("be.visible").click();

    cy.waitAndSee();

    cy.verifyNotBlank();
    cy.verifyShellExists();

    cy.screenshot(`auth-login-${roleCode}`);
  });
});

Cypress.Commands.add("switchLanguage", (locale) => {
  cy.get('[data-cy="topbar-language-switcher"]').should("be.visible").click();
  cy.waitAndSee();
  cy.get(`[data-cy="topbar-language-option-${locale}"]`).should("be.visible").click();
  cy.waitAndSee();
  cy.verifyNotBlank();
});
