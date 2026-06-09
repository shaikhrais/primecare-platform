// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_assessment_queue", () => {
  it("opens and verifies screen intake_coordinator_assessment_queue", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/intake-coordinator-assessment-queue (IntakeCoordinatorAssessmentQueueScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorAssessmentQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorAssessmentQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorAssessmentQueueScreen successfully!\n");

  });
});
