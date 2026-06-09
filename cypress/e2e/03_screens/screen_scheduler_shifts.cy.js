// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_shifts", () => {
  it("opens and verifies screen scheduler_shifts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Scheduler Shifts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Shifts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulershifts-screen").should("be.visible");
  cy.getCy("schedulershifts-title").should("be.visible");
  cy.getCy("schedulershifts-content").should("be.visible");
  cy.getCy("scheduler-btn-submit-event-log").should("be.visible");
  cy.getCy("scheduler-btn-conduct-audit").should("be.visible");
  cy.getCy("scheduler-btn-verify-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Shifts...");
  cy.waitAndSee();
  cy.screenshot("scheduler_shifts");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Shifts successfully!\n");

  });
});
