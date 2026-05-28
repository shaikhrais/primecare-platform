// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - failed_workflow", () => {
  it("opens and verifies screen failed_workflow", () => {
    cy.loginAsRole("qa_specialist");

  cy.visitWithSemantics("/staff/failed-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("failedworkflow-screen").should("be.visible");
  cy.getCy("failedworkflow-title").should("be.visible");
  cy.getCy("failedworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("failed_workflow");

  });
});
