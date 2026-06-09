// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_open_territories", () => {
  it("opens and verifies screen territory_expansion_manager_open_territories", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/open-territories (Territory Expansion Manager Open Territories)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/open-territories");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Open Territories...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanageropenterritories-screen").should("be.visible");
  cy.getCy("territoryexpansionmanageropenterritories-title").should("be.visible");
  cy.getCy("territoryexpansionmanageropenterritories-content").should("be.visible");
  cy.getCy("territory-dashboard-open").should("be.visible");
  cy.getCy("territory-dashboard-analyze").should("be.visible");
  cy.getCy("territory-dashboard-prioritize").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Open Territories...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_open_territories");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Open Territories successfully!\n");

  });
});
