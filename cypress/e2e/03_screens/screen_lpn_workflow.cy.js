// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lpn_workflow", () => {
  it("opens and verifies screen lpn_workflow", () => {
    cy.loginAsRole("lpn");

  cy.visitWithSemantics("/rpn/lpn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("licensed practical nurse (lpn) compliance workflow-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_workflow");

  });
});
