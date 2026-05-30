// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_workflow", () => {
  it("opens and verifies screen compliance_manager_workflow", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/compliance-manager-workflow (ComplianceManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ComplianceManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerworkflow-screen").should("be.visible");
  cy.getCy("compliancemanagerworkflow-title").should("be.visible");
  cy.getCy("compliancemanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ComplianceManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ComplianceManagerWorkflowScreen successfully!\n");

  });
});
