// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_analytics", () => {
  it("opens and verifies screen cto_analytics", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cto-analytics (CtoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cto-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CtoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoanalytics-screen").should("be.visible");
  cy.getCy("ctoanalytics-title").should("be.visible");
  cy.getCy("ctoanalytics-content").should("be.visible");
  cy.getCy("cto-dashboard-project-status").should("be.visible");
  cy.getCy("cto-dashboard-budget-utilization").should("be.visible");
  cy.getCy("cto-dashboard-team-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CtoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CtoAnalyticsScreen successfully!\n");

  });
});
