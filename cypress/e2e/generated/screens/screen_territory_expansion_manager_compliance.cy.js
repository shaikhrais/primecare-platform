// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_compliance", () => {
  it("opens and verifies screen territory_expansion_manager_compliance", () => {
    cy.loginAsRole("territory_expansion");

  cy.visit("/management/territory-expansion-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagercompliance-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-title").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_compliance");

  });
});
