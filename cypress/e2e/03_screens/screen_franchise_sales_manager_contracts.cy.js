// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_contracts", () => {
  it("opens and verifies screen franchise_sales_manager_contracts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/contracts (Franchise Sales Manager Contracts)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/contracts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Contracts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercontracts-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercontracts-title").should("be.visible");
  cy.getCy("franchisesalesmanagercontracts-content").should("be.visible");
  cy.getCy("franchise-sales-manager-contracts-list").should("be.visible");
  cy.getCy("franchise-sales-manager-alerts").should("be.visible");
  cy.getCy("franchise-sales-manager-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Contracts...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_contracts");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Contracts successfully!\n");

  });
});
