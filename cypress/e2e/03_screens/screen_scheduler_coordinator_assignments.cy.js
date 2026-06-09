// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_assignments", () => {
  it("opens and verifies screen scheduler_coordinator_assignments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/assignments (Scheduler Coordinator Assignments)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/assignments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Assignments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorassignments-screen").should("be.visible");
  cy.getCy("schedulercoordinatorassignments-title").should("be.visible");
  cy.getCy("schedulercoordinatorassignments-content").should("be.visible");
  cy.getCy("scheduler-btn-update-assignment").should("be.visible");
  cy.getCy("scheduler-btn-notify-team").should("be.visible");
  cy.getCy("scheduler-metrics-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Assignments...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_assignments");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Assignments successfully!\n");

  });
});
