// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_reports", () => {
  it("opens and verifies screen training_coordinator_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorreports-screen").should("be.visible");
  cy.getCy("trainingcoordinatorreports-title").should("be.visible");
  cy.getCy("trainingcoordinatorreports-content").should("be.visible");
  cy.getCy("training-reports-monitor").should("be.visible");
  cy.getCy("training-data-analyze").should("be.visible");
  cy.getCy("training-report-generate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Reports...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Reports successfully!\n");

  });
});
