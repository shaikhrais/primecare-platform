// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - territory_sales", () => {
  it("tests all screens for role territory_sales", () => {
    cy.loginAsRole("territory_sales");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/marketing/roles/territory_sales_manager/dashboard (TerritorySalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/territory_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for TerritorySalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for TerritorySalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified TerritorySalesManagerDashboardScreen successfully!\n");

  });
});
