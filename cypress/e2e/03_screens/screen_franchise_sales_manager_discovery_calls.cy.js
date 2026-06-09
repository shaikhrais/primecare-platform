// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_discovery_calls", () => {
  it("opens and verifies screen franchise_sales_manager_discovery_calls", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/discovery-calls (Franchise Sales Manager Discovery Calls)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/discovery-calls");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Discovery Calls...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdiscoverycalls-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdiscoverycalls-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdiscoverycalls-content").should("be.visible");
  cy.getCy("franchise-sales-dashboard-call-overview").should("be.visible");
  cy.getCy("franchise-sales-dashboard-call-metrics").should("be.visible");
  cy.getCy("franchise-sales-dashboard-conversion-rate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Discovery Calls...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_discovery_calls");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Discovery Calls successfully!\n");

  });
});
