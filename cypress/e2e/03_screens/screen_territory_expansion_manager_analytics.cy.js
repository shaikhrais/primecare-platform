// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_analytics", () => {
  it("opens and verifies screen territory_expansion_manager_analytics", () => {
    cy.loginAsRole("territory_expansion");

  cy.visit("/management/territory-expansion-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanageranalytics-screen").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-title").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_analytics");

  });
});
