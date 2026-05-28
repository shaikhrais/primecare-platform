// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_workflow", () => {
  it("opens and verifies screen portal_workflow", () => {
    cy.loginAsRole("portal");

  cy.visitWithSemantics("/common/portal-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalworkflow-screen").should("be.visible");
  cy.getCy("portalworkflow-title").should("be.visible");
  cy.getCy("portalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_workflow");

  });
});
