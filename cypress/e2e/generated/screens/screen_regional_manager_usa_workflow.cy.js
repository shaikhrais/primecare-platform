// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_usa_workflow", () => {
  it("opens and verifies screen regional_manager_usa_workflow", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.visit("/management/regional-manager-usa-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaworkflow-screen").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-title").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_workflow");

  });
});
