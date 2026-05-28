// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - daily_operations", () => {
  it("opens and verifies screen daily_operations", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dailyoperations-screen").should("be.visible");
  cy.getCy("dailyoperations-title").should("be.visible");
  cy.getCy("dailyoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("daily_operations");

  });
});
