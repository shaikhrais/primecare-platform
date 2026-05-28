// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_compliance", () => {
  it("opens and verifies screen operations_manager_compliance", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagercompliance-screen").should("be.visible");
  cy.getCy("operationsmanagercompliance-title").should("be.visible");
  cy.getCy("operationsmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");

  });
});
