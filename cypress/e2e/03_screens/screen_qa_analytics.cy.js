// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_analytics", () => {
  it("opens and verifies screen qa_analytics", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/qa-analytics (QaAnalyticsScreen)...");
  cy.visitWithSemantics("/common/qa-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QaAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaanalytics-screen").should("be.visible");
  cy.getCy("qaanalytics-title").should("be.visible");
  cy.getCy("qaanalytics-content").should("be.visible");
  cy.getCy("qa-dashboard-testcase-status").should("be.visible");
  cy.getCy("qa-dashboard-defect-metrics").should("be.visible");
  cy.getCy("qa-dashboard-testcoverage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QaAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified QaAnalyticsScreen successfully!\n");

  });
});
