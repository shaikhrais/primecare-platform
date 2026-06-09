// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_workflow", () => {
  it("opens and verifies screen clinic_workflow", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/clinic-workflow (ClinicWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");
  cy.getCy("clinic-dashboard-kpi").should("be.visible");
  cy.getCy("clinic-dashboard-budget").should("be.visible");
  cy.getCy("clinic-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicWorkflowScreen successfully!\n");

  });
});
