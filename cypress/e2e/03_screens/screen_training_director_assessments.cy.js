// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_assessments", () => {
  it("opens and verifies screen training_director_assessments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/assessments (Training Director Assessments)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/assessments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Assessments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorassessments-screen").should("be.visible");
  cy.getCy("trainingdirectorassessments-title").should("be.visible");
  cy.getCy("trainingdirectorassessments-content").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");
  cy.getCy("assessment-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Assessments...");
  cy.waitAndSee();
  cy.screenshot("training_director_assessments");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Assessments successfully!\n");

  });
});
