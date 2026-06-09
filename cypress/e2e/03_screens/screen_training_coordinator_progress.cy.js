// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_progress", () => {
  it("opens and verifies screen training_coordinator_progress", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Progress)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Progress...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorprogress-screen").should("be.visible");
  cy.getCy("trainingcoordinatorprogress-title").should("be.visible");
  cy.getCy("trainingcoordinatorprogress-content").should("be.visible");
  cy.getCy("training-dashboard-completion-rate").should("be.visible");
  cy.getCy("training-dashboard-feedback-summary").should("be.visible");
  cy.getCy("training-dashboard-performance-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Progress...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_progress");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Progress successfully!\n");

  });
});
