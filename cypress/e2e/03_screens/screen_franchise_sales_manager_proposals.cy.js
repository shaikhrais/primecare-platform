// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_proposals", () => {
  it("opens and verifies screen franchise_sales_manager_proposals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/proposals (Franchise Sales Manager Proposals)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/proposals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Proposals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerproposals-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerproposals-title").should("be.visible");
  cy.getCy("franchisesalesmanagerproposals-content").should("be.visible");
  cy.getCy("franchise-proposal-list").should("be.visible");
  cy.getCy("franchise-btn-approve").should("be.visible");
  cy.getCy("franchise-btn-reject").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Proposals...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_proposals");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Proposals successfully!\n");

  });
});
