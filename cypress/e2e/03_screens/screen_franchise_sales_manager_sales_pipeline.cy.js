// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_sales_pipeline", () => {
  it("opens and verifies screen franchise_sales_manager_sales_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/sales-pipeline (Franchise Sales Manager Sales Pipeline)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/sales-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Sales Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagersalespipeline-screen").should("be.visible");
  cy.getCy("franchisesalesmanagersalespipeline-title").should("be.visible");
  cy.getCy("franchisesalesmanagersalespipeline-content").should("be.visible");
  cy.getCy("franchise-sales-pipeline-chart").should("be.visible");
  cy.getCy("franchise-kpi-widget").should("be.visible");
  cy.getCy("franchise-task-alert-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Sales Pipeline...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_sales_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Sales Pipeline successfully!\n");

  });
});
