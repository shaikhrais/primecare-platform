// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_workflow", () => {
  it("opens and verifies screen clinical_workflow", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/workflow (ClinicalWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");
  cy.getCy("clinical-dashboard-kpi").should("be.visible");
  cy.getCy("clinical-dashboard-policies").should("be.visible");
  cy.getCy("clinical-dashboard-budgets").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalWorkflowScreen successfully!\n");

  });
});
