// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_analytics", () => {
  it("opens and verifies screen intake_analytics", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/analytics (IntakeAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeanalytics-screen").should("be.visible");
  cy.getCy("intakeanalytics-title").should("be.visible");
  cy.getCy("intakeanalytics-content").should("be.visible");
  cy.getCy("intake-dashboard-btn-schedule").should("be.visible");
  cy.getCy("intake-dashboard-btn-verify").should("be.visible");
  cy.getCy("intake-dashboard-btn-submitFollowUp").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeAnalyticsScreen successfully!\n");

  });
});
