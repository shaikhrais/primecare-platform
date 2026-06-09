// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_scheduling", () => {
  it("opens and verifies screen intake_coordinator_scheduling", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator Scheduling)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator Scheduling...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorscheduling-screen").should("be.visible");
  cy.getCy("intakecoordinatorscheduling-title").should("be.visible");
  cy.getCy("intakecoordinatorscheduling-content").should("be.visible");
  cy.getCy("intake-scheduler-btn-schedule").should("be.visible");
  cy.getCy("intake-manager-btn-update").should("be.visible");
  cy.getCy("intake-communication-btn-send").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator Scheduling...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_scheduling");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator Scheduling successfully!\n");

  });
});
