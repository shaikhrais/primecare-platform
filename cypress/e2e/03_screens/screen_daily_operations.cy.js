// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - daily_operations", () => {
  it("opens and verifies screen daily_operations", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/daily-operations (DailyOperationsScreen)...");
  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DailyOperationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dailyoperations-screen").should("be.visible");
  cy.getCy("dailyoperations-title").should("be.visible");
  cy.getCy("dailyoperations-content").should("be.visible");
  cy.getCy("operations-kpi-widget").should("be.visible");
  cy.getCy("operations-compliance-status").should("be.visible");
  cy.getCy("operations-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DailyOperationsScreen...");
  cy.waitAndSee();
  cy.screenshot("daily_operations");
  
  cy.task("log", "✅ PROGRESS: - Verified DailyOperationsScreen successfully!\n");

  });
});
