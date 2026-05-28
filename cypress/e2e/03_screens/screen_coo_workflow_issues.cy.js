// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_workflow_issues", () => {
  it("opens and verifies screen coo_workflow_issues", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/coo-workflow-issues");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflowissues-screen").should("be.visible");
  cy.getCy("cooworkflowissues-title").should("be.visible");
  cy.getCy("cooworkflowissues-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_workflow_issues");

  });
});
