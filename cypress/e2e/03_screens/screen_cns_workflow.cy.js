// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cns_workflow", () => {
  it("opens and verifies screen cns_workflow", () => {
    cy.loginAsRole("cns");

  cy.visitWithSemantics("/rn/cns-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinical nurse specialist compliance workflow-screen").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-title").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_workflow");

  });
});
