// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_workflow", () => {
  it("opens and verifies screen general_manager_workflow", () => {
    cy.loginAsRole("gm");

  cy.visitWithSemantics("/management/general-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerworkflow-screen").should("be.visible");
  cy.getCy("generalmanagerworkflow-title").should("be.visible");
  cy.getCy("generalmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_workflow");

  });
});
