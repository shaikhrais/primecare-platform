// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_reports", () => {
  it("opens and verifies screen scheduler_coordinator_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/reports (Scheduler Coordinator Reports)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorreports-screen").should("be.visible");
  cy.getCy("schedulercoordinatorreports-title").should("be.visible");
  cy.getCy("schedulercoordinatorreports-content").should("be.visible");
  cy.getCy("scheduler-reports-status").should("be.visible");
  cy.getCy("scheduler-notify-team").should("be.visible");
  cy.getCy("scheduler-analyze-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Reports...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Reports successfully!\n");

  });
});
