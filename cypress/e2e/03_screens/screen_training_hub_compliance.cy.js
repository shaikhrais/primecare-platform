// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_hub_compliance", () => {
  it("opens and verifies screen training_hub_compliance", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/training-hub-compliance (TrainingHubComplianceScreen)...");
  cy.visitWithSemantics("/common/training-hub-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingHubComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubcompliance-screen").should("be.visible");
  cy.getCy("traininghubcompliance-title").should("be.visible");
  cy.getCy("traininghubcompliance-content").should("be.visible");
  cy.getCy("training-hub-compliance-status").should("be.visible");
  cy.getCy("training-hub-training-modules").should("be.visible");
  cy.getCy("training-hub-audit-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingHubComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingHubComplianceScreen successfully!\n");

  });
});
