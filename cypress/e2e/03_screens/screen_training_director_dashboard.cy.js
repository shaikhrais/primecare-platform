// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_dashboard", () => {
  it("opens and verifies screen training_director_dashboard", () => {
    cy.loginAsRole("training_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-adjust-program").should("be.visible");
  cy.getCy("training-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingDirectorDashboardScreen successfully!\n");

  });
});
