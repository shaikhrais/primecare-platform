// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_command_center", () => {
  it("opens and verifies screen scheduler_command_center", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-command-center (SchedulerCommandCenterScreen)...");
  cy.visitWithSemantics("/staff/scheduler-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercommandcenter-screen").should("be.visible");
  cy.getCy("schedulercommandcenter-title").should("be.visible");
  cy.getCy("schedulercommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerCommandCenterScreen successfully!\n");

  });
});
