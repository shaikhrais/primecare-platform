// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_manager_analytics", () => {
  it("opens and verifies screen hr_manager_analytics", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/hr-manager-analytics (HrManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified HrManagerAnalyticsScreen successfully!\n");

  });
});
