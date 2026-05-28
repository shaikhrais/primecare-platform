// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_workflow", () => {
  it("opens and verifies screen cfo_workflow", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/cfo-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoworkflow-screen").should("be.visible");
  cy.getCy("cfoworkflow-title").should("be.visible");
  cy.getCy("cfoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_workflow");

  });
});
