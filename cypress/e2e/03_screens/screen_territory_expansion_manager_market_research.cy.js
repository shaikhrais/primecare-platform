// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_market_research", () => {
  it("opens and verifies screen territory_expansion_manager_market_research", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/market-research (Territory Expansion Manager Market Research)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/market-research");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Market Research...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagermarketresearch-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagermarketresearch-title").should("be.visible");
  cy.getCy("territoryexpansionmanagermarketresearch-content").should("be.visible");
  cy.getCy("marketresearch-btn-generate-report").should("be.visible");
  cy.getCy("marketresearch-btn-analyze-data").should("be.visible");
  cy.getCy("marketresearch-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Market Research...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_market_research");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Market Research successfully!\n");

  });
});
