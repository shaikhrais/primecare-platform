// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_dashboard", () => {
  it("opens and verifies screen scheduler_dashboard", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler/dashboard (SchedulerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerdashboard-screen").should("be.visible");
  cy.getCy("schedulerdashboard-title").should("be.visible");
  cy.getCy("schedulerdashboard-content").should("be.visible");
  cy.getCy("scheduler-dashboard-btn-resolve-conflict").should("be.visible");
  cy.getCy("scheduler-dashboard-btn-optimize-schedule").should("be.visible");
  cy.getCy("scheduler-dashboard-btn-view-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerDashboardScreen successfully!\n");

  });
});
