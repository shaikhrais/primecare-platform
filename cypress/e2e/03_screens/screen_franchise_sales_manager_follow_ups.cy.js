// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_follow_ups", () => {
  it("opens and verifies screen franchise_sales_manager_follow_ups", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/franchise_sales_manager/follow-ups (Franchise Sales Manager Follow Ups)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/follow-ups");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Follow Ups...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerfollowups-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerfollowups-title").should("be.visible");
  cy.getCy("franchisesalesmanagerfollowups-content").should("be.visible");
  cy.getCy("franchise-lead-list").should("be.visible");
  cy.getCy("followup-metrics-card").should("be.visible");
  cy.getCy("alert-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Follow Ups...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_follow_ups");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Follow Ups successfully!\n");

  });
});
