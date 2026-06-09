// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_analytics", () => {
  it("opens and verifies screen franchise_sales_analytics", () => {
    cy.loginAsRole("franchise_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-sales-analytics (Franchise Sales Manager Analytics)...");
  cy.visitWithSemantics("/executive/franchise-sales-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesanalytics-screen").should("be.visible");
  cy.getCy("franchisesalesanalytics-title").should("be.visible");
  cy.getCy("franchisesalesanalytics-content").should("be.visible");
  cy.getCy("franchise-sales-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("franchise-sales-dashboard-btn-send-training-invite").should("be.visible");
  cy.getCy("franchise-sales-dashboard-btn-resolve-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Analytics...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Analytics successfully!\n");

  });
});
