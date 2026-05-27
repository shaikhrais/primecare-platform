// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_workflow", () => {
  it("opens and verifies screen qa_workflow", () => {
    cy.loginAsRole("qa_specialist");

  cy.visit("/common/qa-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaworkflow-screen").should("be.visible");
  cy.getCy("qaworkflow-title").should("be.visible");
  cy.getCy("qaworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_workflow");

  });
});
