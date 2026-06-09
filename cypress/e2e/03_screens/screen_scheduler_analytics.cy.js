// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_analytics", () => {
  it("opens and verifies screen scheduler_analytics", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-analytics (SchedulerAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleranalytics-screen").should("be.visible");
  cy.getCy("scheduleranalytics-title").should("be.visible");
  cy.getCy("scheduleranalytics-content").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-submit-incident").should("be.visible");
  cy.getCy("scheduler-btn-view-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerAnalyticsScreen successfully!\n");

  });
});
