// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - legal_workflow", () => {
  it("opens and verifies screen legal_workflow", () => {
    cy.loginAsRole("legal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/legal-workflow (LegalWorkflowScreen)...");
  cy.visitWithSemantics("/executive/legal-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LegalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalworkflow-screen").should("be.visible");
  cy.getCy("legalworkflow-title").should("be.visible");
  cy.getCy("legalworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LegalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified LegalWorkflowScreen successfully!\n");

  });
});
