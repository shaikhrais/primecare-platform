// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_dashboard", () => {
  it("opens and verifies screen territory_sales_manager_dashboard", () => {
    cy.loginAsRole("territory_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/territory-sales-manager-dashboard (TerritorySalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritorySalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritorySalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritorySalesManagerDashboardScreen successfully!\n");

  });
});
