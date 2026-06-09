// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_territory_map", () => {
  it("opens and verifies screen territory_expansion_manager_territory_map", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/territory-map (Territory Expansion Manager Territory Map)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/territory-map");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Territory Map...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerterritorymap-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerterritorymap-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerterritorymap-content").should("be.visible");
  cy.getCy("territory-map").should("be.visible");
  cy.getCy("territory-performance-chart").should("be.visible");
  cy.getCy("generate-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Territory Map...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_territory_map");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Territory Map successfully!\n");

  });
});
