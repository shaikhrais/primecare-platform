// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_compliance", () => {
  it("opens and verifies screen training_compliance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/training-compliance (Training Compliance)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/training-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Compliance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcompliance-screen").should("be.visible");
  cy.getCy("trainingcompliance-title").should("be.visible");
  cy.getCy("trainingcompliance-content").should("be.visible");
  cy.getCy("training-compliance-overview").should("be.visible");
  cy.getCy("training-completion-chart").should("be.visible");
  cy.getCy("training-user-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Compliance...");
  cy.waitAndSee();
  cy.screenshot("training_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Compliance successfully!\n");

  });
});
