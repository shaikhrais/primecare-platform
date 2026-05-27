// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.bus_dev@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Language - bus_dev", () => {
  it("switches active languages for bus_dev", () => {
    login();

    cy.get('[data-cy="topbar-language-switcher"]').should("be.visible").click();
    cy.wait(2000);
    cy.get('[data-cy="topbar-language-option-en"]').should("be.visible").click();
    cy.wait(2000);
    cy.get('[data-cy="app-topbar"]').should("be.visible");
    cy.get('[data-cy="app-sidebar"]').should("be.visible");
    cy.get('[data-cy="app-content-slot"]').should("be.visible");
    cy.screenshot("language_bus_dev_en");

    cy.get('[data-cy="topbar-language-switcher"]').should("be.visible").click();
    cy.wait(2000);
    cy.get('[data-cy="topbar-language-option-fr"]').should("be.visible").click();
    cy.wait(2000);
    cy.get('[data-cy="app-topbar"]').should("be.visible");
    cy.get('[data-cy="app-sidebar"]').should("be.visible");
    cy.get('[data-cy="app-content-slot"]').should("be.visible");
    cy.screenshot("language_bus_dev_fr");

    cy.get('[data-cy="topbar-language-switcher"]').should("be.visible").click();
    cy.wait(2000);
    cy.get('[data-cy="topbar-language-option-es"]').should("be.visible").click();
    cy.wait(2000);
    cy.get('[data-cy="app-topbar"]').should("be.visible");
    cy.get('[data-cy="app-sidebar"]').should("be.visible");
    cy.get('[data-cy="app-content-slot"]').should("be.visible");
    cy.screenshot("language_bus_dev_es");

  });
});
