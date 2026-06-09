// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_prospects", () => {
  it("opens and verifies screen franchise_sales_manager_prospects", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/prospects (Franchise Sales Manager Prospects)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/prospects");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Prospects...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerprospects-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerprospects-title").should("be.visible");
  cy.getCy("franchisesalesmanagerprospects-content").should("be.visible");
  cy.getCy("franchise-sales-manager-prospects-overview").should("be.visible");
  cy.getCy("franchise-sales-manager-update-status").should("be.visible");
  cy.getCy("franchise-sales-manager-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Prospects...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_prospects");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Prospects successfully!\n");

  });
});
