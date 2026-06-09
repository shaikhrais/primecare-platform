// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_reports", () => {
  it("opens and verifies screen training_director_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/reports (Training Director Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorreports-screen").should("be.visible");
  cy.getCy("trainingdirectorreports-title").should("be.visible");
  cy.getCy("trainingdirectorreports-content").should("be.visible");
  cy.getCy("training-dashboard-summary").should("be.visible");
  cy.getCy("training-dashboard-alerts").should("be.visible");
  cy.getCy("training-dashboard-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Reports...");
  cy.waitAndSee();
  cy.screenshot("training_director_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Reports successfully!\n");

  });
});
