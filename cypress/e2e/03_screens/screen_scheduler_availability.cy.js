// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_availability", () => {
  it("opens and verifies screen scheduler_availability", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Scheduler Availability)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Availability...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleravailability-screen").should("be.visible");
  cy.getCy("scheduleravailability-title").should("be.visible");
  cy.getCy("scheduleravailability-content").should("be.visible");
  cy.getCy("scheduler-btn-submit-event-log").should("be.visible");
  cy.getCy("scheduler-btn-refresh-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Availability...");
  cy.waitAndSee();
  cy.screenshot("scheduler_availability");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Availability successfully!\n");

  });
});
