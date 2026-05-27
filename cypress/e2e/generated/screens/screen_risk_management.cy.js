// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - risk_management", () => {
  it("opens and verifies screen risk_management", () => {
    cy.loginAsRole("ceo");

  cy.visit("/executive/risk-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("riskmanagement-screen").should("be.visible");
  cy.getCy("riskmanagement-title").should("be.visible");
  cy.getCy("riskmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("risk_management");

  });
});
