// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - schedule", () => {
  it("opens and verifies screen schedule", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/psw-schedule (ScheduleScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/psw-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedule-screen").should("be.visible");
  cy.getCy("schedule-title").should("be.visible");
  cy.getCy("schedule-content").should("be.visible");
  cy.getCy("schedule-visit-btn").should("be.visible");
  cy.getCy("report-health-btn").should("be.visible");
  cy.getCy("administer-medication-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified ScheduleScreen successfully!\n");

  });
});
