// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - therapist_workflow", () => {
  it("opens and verifies screen therapist_workflow", () => {
    cy.loginAsRole("therapist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/therapist/workflow (Therapist Compliance Workflow)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Therapist Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistworkflow-screen").should("be.visible");
  cy.getCy("therapistworkflow-title").should("be.visible");
  cy.getCy("therapistworkflow-content").should("be.visible");
  cy.getCy("therapist-dashboard-btn-quality-sweep").should("be.visible");
  cy.getCy("therapist-dashboard-btn-view-progress").should("be.visible");
  cy.getCy("therapist-dashboard-btn-respond-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Therapist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("therapist_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Therapist Compliance Workflow successfully!\n");

  });
});
