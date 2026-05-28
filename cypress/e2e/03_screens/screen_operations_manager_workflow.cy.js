// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_workflow", () => {
  it("opens and verifies screen operations_manager_workflow", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerworkflow-screen").should("be.visible");
  cy.getCy("operationsmanagerworkflow-title").should("be.visible");
  cy.getCy("operationsmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");

  });
});
