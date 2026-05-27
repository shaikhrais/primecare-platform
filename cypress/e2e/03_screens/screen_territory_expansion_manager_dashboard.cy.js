// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_dashboard", () => {
  it("opens and verifies screen territory_expansion_manager_dashboard", () => {
    cy.loginAsRole("territory_expansion");

  cy.visit("/management/territory-expansion-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_dashboard");

  });
});
