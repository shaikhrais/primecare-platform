// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infrastructure_analytics", () => {
  it("opens and verifies screen infrastructure_analytics", () => {
    cy.loginAsRole("infrastructure");

  cy.visitWithSemantics("/common/infrastructure-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureanalytics-screen").should("be.visible");
  cy.getCy("infrastructureanalytics-title").should("be.visible");
  cy.getCy("infrastructureanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_analytics");

  });
});
