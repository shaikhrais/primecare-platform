// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_workflow", () => {
  it("opens and verifies screen coo_workflow", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/coo-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflow-screen").should("be.visible");
  cy.getCy("cooworkflow-title").should("be.visible");
  cy.getCy("cooworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_workflow");

  });
});
