// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_dashboard", () => {
  it("opens and verifies screen franchise_sales_manager_dashboard", () => {
    cy.loginAsRole("franchise_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/dashboard (FranchiseSalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseSalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");
  cy.getCy("franchise-dashboard-kpi").should("be.visible");
  cy.getCy("franchise-dashboard-sales-trend").should("be.visible");
  cy.getCy("franchise-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseSalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseSalesManagerDashboardScreen successfully!\n");

  });
});
