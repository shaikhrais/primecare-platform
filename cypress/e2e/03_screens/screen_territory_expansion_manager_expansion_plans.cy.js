// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_expansion_plans", () => {
  it("opens and verifies screen territory_expansion_manager_expansion_plans", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/expansion-plans (Territory Expansion Manager Expansion Plans)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/expansion-plans");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Expansion Plans...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerexpansionplans-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerexpansionplans-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerexpansionplans-content").should("be.visible");
  cy.getCy("expansion-plans-summary").should("be.visible");
  cy.getCy("kpi-widget").should("be.visible");
  cy.getCy("market-analysis-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Expansion Plans...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_expansion_plans");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Expansion Plans successfully!\n");

  });
});
