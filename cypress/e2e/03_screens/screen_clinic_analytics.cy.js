// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_analytics", () => {
  it("opens and verifies screen clinic_analytics", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/clinic-analytics (ClinicAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");
  cy.getCy("clinic-analytics-btn-view-reports").should("be.visible");
  cy.getCy("clinic-analytics-btn-manage-budgets").should("be.visible");
  cy.getCy("clinic-analytics-btn-staff-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicAnalyticsScreen successfully!\n");

  });
});
