// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_reports", () => {
  it("opens and verifies screen franchise_sales_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/reports (Franchise Sales Manager Reports)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerreports-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerreports-title").should("be.visible");
  cy.getCy("franchisesalesmanagerreports-content").should("be.visible");
  cy.getCy("franchise-sales-data-visualization").should("be.visible");
  cy.getCy("franchise-alerts-widget").should("be.visible");
  cy.getCy("franchise-performance-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Reports successfully!\n");

  });
});
