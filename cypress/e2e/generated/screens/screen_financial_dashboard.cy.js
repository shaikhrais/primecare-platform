// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - financial_dashboard", () => {
  it("opens and verifies screen financial_dashboard", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/financial-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("financial_dashboard");

  });
});
