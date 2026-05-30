// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_analytics", () => {
  it("opens and verifies screen franchise_analytics", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/franchise-analytics (FranchiseAnalyticsScreen)...");
  cy.visitWithSemantics("/common/franchise-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseAnalyticsScreen successfully!\n");

  });
});
