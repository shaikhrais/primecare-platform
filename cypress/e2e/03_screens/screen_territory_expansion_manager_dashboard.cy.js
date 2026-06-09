// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_dashboard", () => {
  it("opens and verifies screen territory_expansion_manager_dashboard", () => {
    cy.loginAsRole("territory_expansion");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/dashboard (TerritoryExpansionManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritoryExpansionManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");
  cy.getCy("territory-dashboard-kpi").should("be.visible");
  cy.getCy("territory-dashboard-telemetry").should("be.visible");
  cy.getCy("territory-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritoryExpansionManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritoryExpansionManagerDashboardScreen successfully!\n");

  });
});
