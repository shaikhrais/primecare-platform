// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_analytics", () => {
  it("opens and verifies screen finance_director_analytics", () => {
    cy.loginAsRole("finance_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/finance-director-analytics (FinanceDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/finance-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FinanceDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-monitor").should("be.visible");
  cy.getCy("finance-budget-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FinanceDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified FinanceDirectorAnalyticsScreen successfully!\n");

  });
});
