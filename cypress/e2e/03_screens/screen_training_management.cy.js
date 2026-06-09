// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_management", () => {
  it("opens and verifies screen training_management", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/training-management (TrainingManagementScreen)...");
  cy.visitWithSemantics("/management/training-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("training_management");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingManagementScreen successfully!\n");

  });
});
