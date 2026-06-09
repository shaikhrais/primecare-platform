// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_hub", () => {
  it("opens and verifies screen training_director_hub", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/hub (Training Director Hub)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/hub");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Hub...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorhub-screen").should("be.visible");
  cy.getCy("trainingdirectorhub-title").should("be.visible");
  cy.getCy("trainingdirectorhub-content").should("be.visible");
  cy.getCy("training-dashboard-btn-schedule").should("be.visible");
  cy.getCy("training-dashboard-btn-review-feedback").should("be.visible");
  cy.getCy("training-dashboard-btn-analyze-completion").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Hub...");
  cy.waitAndSee();
  cy.screenshot("training_director_hub");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Hub successfully!\n");

  });
});
