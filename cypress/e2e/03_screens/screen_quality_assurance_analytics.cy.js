// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_analytics", () => {
  it("opens and verifies screen quality_assurance_analytics", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/quality-assurance-analytics (QualityAssuranceAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QualityAssuranceAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceanalytics-screen").should("be.visible");
  cy.getCy("qualityassuranceanalytics-title").should("be.visible");
  cy.getCy("qualityassuranceanalytics-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-view-test-plans").should("be.visible");
  cy.getCy("qa-dashboard-btn-run-tests").should("be.visible");
  cy.getCy("qa-dashboard-btn-log-defect").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QualityAssuranceAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified QualityAssuranceAnalyticsScreen successfully!\n");

  });
});
