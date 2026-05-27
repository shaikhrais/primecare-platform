// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_workflow", () => {
  it("opens and verifies screen territory_expansion_manager_workflow", () => {
    cy.loginAsRole("territory_expansion");

  cy.visit("/management/territory-expansion-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerworkflow-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_workflow");

  });
});
