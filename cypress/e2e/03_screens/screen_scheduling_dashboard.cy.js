// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduling_dashboard", () => {
  it("opens and verifies screen scheduling_dashboard", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduling-dashboard (SchedulingDashboardScreen)...");
  cy.visitWithSemantics("/staff/scheduling-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingdashboard-screen").should("be.visible");
  cy.getCy("schedulingdashboard-title").should("be.visible");
  cy.getCy("schedulingdashboard-content").should("be.visible");
  cy.getCy("scheduling-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("scheduling-dashboard-btn-send-update").should("be.visible");
  cy.getCy("scheduling-dashboard-btn-log-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulingDashboardScreen successfully!\n");

  });
});
