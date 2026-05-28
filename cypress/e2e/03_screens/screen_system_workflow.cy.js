// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_workflow", () => {
  it("opens and verifies screen system_workflow", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/common/system-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemworkflow-screen").should("be.visible");
  cy.getCy("systemworkflow-title").should("be.visible");
  cy.getCy("systemworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_workflow");

  });
});
