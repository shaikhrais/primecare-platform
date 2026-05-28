// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shareholder_workflow", () => {
  it("opens and verifies screen shareholder_workflow", () => {
    cy.loginAsRole("shareholder");

  cy.visitWithSemantics("/executive/shareholder-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderworkflow-screen").should("be.visible");
  cy.getCy("shareholderworkflow-title").should("be.visible");
  cy.getCy("shareholderworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_workflow");

  });
});
