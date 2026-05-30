// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_schedule", () => {
  it("opens and verifies screen caregiver_schedule", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/schedule (CaregiverScheduleScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CaregiverScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverschedule-screen").should("be.visible");
  cy.getCy("caregiverschedule-title").should("be.visible");
  cy.getCy("caregiverschedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CaregiverScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified CaregiverScheduleScreen successfully!\n");

  });
});
