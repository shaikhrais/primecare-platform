// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - workflow_issue", () => {
  it("opens and verifies screen workflow_issue", () => {
    cy.loginAsRole("coo");

  cy.visit("/executive/workflow-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowissue-screen").should("be.visible");
  cy.getCy("workflowissue-title").should("be.visible");
  cy.getCy("workflowissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_issue");

  });
});
