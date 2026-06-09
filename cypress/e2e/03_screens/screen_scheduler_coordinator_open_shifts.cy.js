// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_open_shifts", () => {
  it("opens and verifies screen scheduler_coordinator_open_shifts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/open-shifts (Scheduler Coordinator Open Shifts)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/open-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Open Shifts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatoropenshifts-screen").should("be.visible");
  cy.getCy("schedulercoordinatoropenshifts-title").should("be.visible");
  cy.getCy("schedulercoordinatoropenshifts-content").should("be.visible");
  cy.getCy("scheduler-btn-assign-shift").should("be.visible");
  cy.getCy("scheduler-btn-review-requests").should("be.visible");
  cy.getCy("scheduler-btn-notify-team").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Open Shifts...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_open_shifts");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Open Shifts successfully!\n");

  });
});
