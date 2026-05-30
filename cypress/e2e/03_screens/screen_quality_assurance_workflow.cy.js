// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_workflow", () => {
  it("opens and verifies screen quality_assurance_workflow", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/quality-assurance-workflow (QualityAssuranceWorkflowScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QualityAssuranceWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceworkflow-screen").should("be.visible");
  cy.getCy("qualityassuranceworkflow-title").should("be.visible");
  cy.getCy("qualityassuranceworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QualityAssuranceWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified QualityAssuranceWorkflowScreen successfully!\n");

  });
});
