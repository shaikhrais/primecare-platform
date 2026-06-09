// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_materials", () => {
  it("opens and verifies screen training_coordinator_materials", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Materials)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Materials...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatormaterials-screen").should("be.visible");
  cy.getCy("trainingcoordinatormaterials-title").should("be.visible");
  cy.getCy("trainingcoordinatormaterials-content").should("be.visible");
  cy.getCy("training-coordinator-loading-indicator").should("be.visible");
  cy.getCy("training-coordinator-error-message").should("be.visible");
  cy.getCy("training-coordinator-feedback-form").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Materials...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_materials");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Materials successfully!\n");

  });
});
