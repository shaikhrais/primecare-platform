// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_schedule", () => {
  it("opens and verifies screen hsw_schedule", () => {
    cy.loginAsRole("hsw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/hsw-schedule (HswScheduleScreen)...");
  cy.visitWithSemantics("/clinical/hsw-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HswScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswschedule-screen").should("be.visible");
  cy.getCy("hswschedule-title").should("be.visible");
  cy.getCy("hswschedule-content").should("be.visible");
  cy.getCy("hsw-schedule-btn-swap").should("be.visible");
  cy.getCy("hsw-schedule-btn-log-mileage").should("be.visible");
  cy.getCy("hsw-schedule-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HswScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified HswScheduleScreen successfully!\n");

  });
});
