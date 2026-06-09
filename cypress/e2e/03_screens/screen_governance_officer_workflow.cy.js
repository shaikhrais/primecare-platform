// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_workflow", () => {
  it("opens and verifies screen governance_officer_workflow", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/governance-officer-workflow (GovernanceOfficerWorkflowScreen)...");
  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GovernanceOfficerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-submit-incident").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GovernanceOfficerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified GovernanceOfficerWorkflowScreen successfully!\n");

  });
});
