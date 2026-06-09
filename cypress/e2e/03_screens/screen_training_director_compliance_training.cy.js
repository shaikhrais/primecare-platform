// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_compliance_training", () => {
  it("opens and verifies screen training_director_compliance_training", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/compliance-training (Training Director Compliance Training)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/compliance-training");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Compliance Training...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliancetraining-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliancetraining-title").should("be.visible");
  cy.getCy("trainingdirectorcompliancetraining-content").should("be.visible");
  cy.getCy("training-completion-rate-card").should("be.visible");
  cy.getCy("training-deadline-list").should("be.visible");
  cy.getCy("user-feedback-trend-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Compliance Training...");
  cy.waitAndSee();
  cy.screenshot("training_director_compliance_training");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Compliance Training successfully!\n");

  });
});
