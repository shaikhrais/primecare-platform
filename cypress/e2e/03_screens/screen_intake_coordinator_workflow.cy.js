// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_workflow", () => {
  it("opens and verifies screen intake_coordinator_workflow", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-workflow (IntakeCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorworkflow-screen").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-title").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-content").should("be.visible");
  cy.getCy("intake-coordinator-btn-schedule").should("be.visible");
  cy.getCy("intake-coordinator-btn-verify").should("be.visible");
  cy.getCy("intake-coordinator-btn-communicate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorWorkflowScreen successfully!\n");

  });
});
