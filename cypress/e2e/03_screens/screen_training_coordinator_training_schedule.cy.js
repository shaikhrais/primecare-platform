// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_training_schedule", () => {
  it("opens and verifies screen training_coordinator_training_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Training Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Training Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatortrainingschedule-screen").should("be.visible");
  cy.getCy("trainingcoordinatortrainingschedule-title").should("be.visible");
  cy.getCy("trainingcoordinatortrainingschedule-content").should("be.visible");
  cy.getCy("training-schedule-overview").should("be.visible");
  cy.getCy("attendance-tracker").should("be.visible");
  cy.getCy("feedback-collection").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Training Schedule...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_training_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Training Schedule successfully!\n");

  });
});
