// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_analytics", () => {
  it("opens and verifies screen clinical_analytics", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/analytics (ClinicalAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");
  cy.getCy("clinical-analytics-kpi-chart").should("be.visible");
  cy.getCy("clinical-analytics-staff-performance").should("be.visible");
  cy.getCy("clinical-analytics-compliance-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalAnalyticsScreen successfully!\n");

  });
});
