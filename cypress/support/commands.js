Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[data-cy="${id}"]`);
});

Cypress.Commands.add("loginAsRole", (roleCode) => {
  cy.fixture("governance/test_users.json").then((users) => {
    const user = users.find((u) => u.role_code === roleCode);

    if (!user) {
      throw new Error(`No seeded test user found for role: ${roleCode}`);
    }

    cy.visit("/login");
    cy.wait(2000);

    cy.get('[data-cy="login-email"]').clear().type(user.email);
    cy.get('[data-cy="login-password"]').clear().type(user.password, {
      log: false,
    });

    cy.get('[data-cy="login-submit"]').click();
    cy.wait(2000);

    cy.get('[data-cy="app-shell"]').should("exist");
  });
});

Cypress.Commands.add("switchLanguage", (localeCode) => {
  cy.get('[data-cy="topbar-language-switcher"]').should("exist").click();
  cy.wait(2000);

  cy.get(`[data-cy="topbar-language-option-${localeCode}"]`)
    .should("exist")
    .click();

  cy.wait(2000);
});

Cypress.Commands.add("verifyShellExists", () => {
  cy.get('[data-cy="app-shell"]').should("exist");
  cy.get('[data-cy="app-topbar"]').should("exist");
  cy.get('[data-cy="app-sidebar"]').should("exist");
  cy.get('[data-cy="app-content-slot"]').should("exist");
});
