// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_workflow", () => {
  it("opens and verifies screen regional_bdm_workflow", () => {
    cy.loginAsRole("regional_bdm");

  cy.visitWithSemantics("/management/regional-bdm-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmworkflow-screen").should("be.visible");
  cy.getCy("regionalbdmworkflow-title").should("be.visible");
  cy.getCy("regionalbdmworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_workflow");

  });
});
