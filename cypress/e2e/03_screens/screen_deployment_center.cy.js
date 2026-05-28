// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - deployment_center", () => {
  it("opens and verifies screen deployment_center", () => {
    cy.loginAsRole("cto");

  cy.visitWithSemantics("/executive/deployment-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("deploymentcenter-screen").should("be.visible");
  cy.getCy("deploymentcenter-title").should("be.visible");
  cy.getCy("deploymentcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("deployment_center");

  });
});
