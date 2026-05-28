// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_workflow", () => {
  it("opens and verifies screen finance_director_workflow", () => {
    cy.loginAsRole("finance_director");

  cy.visitWithSemantics("/executive/finance-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");

  });
});
