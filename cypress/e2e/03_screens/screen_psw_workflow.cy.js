// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_workflow", () => {
  it("opens and verifies screen psw_workflow", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/psw-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswworkflow-screen").should("be.visible");
  cy.getCy("pswworkflow-title").should("be.visible");
  cy.getCy("pswworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_workflow");

  });
});
