// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infrastructure_workflow", () => {
  it("opens and verifies screen infrastructure_workflow", () => {
    cy.loginAsRole("infrastructure");

  cy.visitWithSemantics("/common/infrastructure-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureworkflow-screen").should("be.visible");
  cy.getCy("infrastructureworkflow-title").should("be.visible");
  cy.getCy("infrastructureworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_workflow");

  });
});
