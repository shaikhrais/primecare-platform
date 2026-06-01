// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_shift_tracker", () => {
  it("opens and verifies screen psw_shift_tracker", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/schedule (PswShiftTrackerScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswShiftTrackerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswshifttracker-screen").should("be.visible");
  cy.getCy("pswshifttracker-title").should("be.visible");
  cy.getCy("pswshifttracker-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswShiftTrackerScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified PswShiftTrackerScreen successfully!\n");

  });
});
