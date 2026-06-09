// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_leads", () => {
  it("opens and verifies screen franchise_sales_manager_leads", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/leads (Franchise Sales Manager Leads)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/leads");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerleads-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerleads-title").should("be.visible");
  cy.getCy("franchisesalesmanagerleads-content").should("be.visible");
  cy.getCy("franchise-sales-manager-btn-update-status").should("be.visible");
  cy.getCy("franchise-sales-manager-btn-generate-report").should("be.visible");
  cy.getCy("franchise-sales-manager-btn-send-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Leads...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_leads");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Leads successfully!\n");

  });
});
