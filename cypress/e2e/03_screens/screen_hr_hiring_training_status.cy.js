// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_training_status", () => {
  it("opens and verifies screen hr_hiring_training_status", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/training-status (Hr Hiring Training Status)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/training-status");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Hiring Training Status...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringtrainingstatus-screen").should("be.visible");
  cy.getCy("hrhiringtrainingstatus-title").should("be.visible");
  cy.getCy("hrhiringtrainingstatus-content").should("be.visible");
  cy.getCy("training-completion-chart").should("be.visible");
  cy.getCy("training-progress-graph").should("be.visible");
  cy.getCy("user-feedback-section").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Hiring Training Status...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_training_status");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Hiring Training Status successfully!\n");

  });
});
