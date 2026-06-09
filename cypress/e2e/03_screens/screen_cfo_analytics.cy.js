// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_analytics", () => {
  it("opens and verifies screen cfo_analytics", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-analytics (CfoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cfo-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoanalytics-screen").should("be.visible");
  cy.getCy("cfoanalytics-title").should("be.visible");
  cy.getCy("cfoanalytics-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-financial-statement").should("be.visible");
  cy.getCy("cfo-dashboard-budget-actual").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoAnalyticsScreen successfully!\n");

  });
});
