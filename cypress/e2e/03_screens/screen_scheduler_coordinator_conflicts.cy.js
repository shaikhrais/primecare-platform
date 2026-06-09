// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_conflicts", () => {
  it("opens and verifies screen scheduler_coordinator_conflicts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/conflicts (Scheduler Coordinator Conflicts)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/conflicts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Conflicts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorconflicts-screen").should("be.visible");
  cy.getCy("schedulercoordinatorconflicts-title").should("be.visible");
  cy.getCy("schedulercoordinatorconflicts-content").should("be.visible");
  cy.getCy("scheduler-btn-resolve").should("be.visible");
  cy.getCy("scheduler-btn-update").should("be.visible");
  cy.getCy("scheduler-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Conflicts...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_conflicts");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Conflicts successfully!\n");

  });
});
