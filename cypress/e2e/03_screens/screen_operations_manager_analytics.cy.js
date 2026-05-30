// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_analytics", () => {
  it("opens and verifies screen operations_manager_analytics", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/operations-manager-analytics (OperationsManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/operations-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OperationsManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanageranalytics-screen").should("be.visible");
  cy.getCy("operationsmanageranalytics-title").should("be.visible");
  cy.getCy("operationsmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OperationsManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified OperationsManagerAnalyticsScreen successfully!\n");

  });
});
