// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_dashboard", () => {
  it("opens and verifies screen training_dashboard", () => {
    cy.loginAsRole("training_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/training-dashboard (TrainingDashboardScreen)...");
  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-add-session").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingDashboardScreen successfully!\n");

  });
});
