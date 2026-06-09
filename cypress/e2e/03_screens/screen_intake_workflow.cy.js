// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_workflow", () => {
  it("opens and verifies screen intake_workflow", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/workflow (IntakeWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeworkflow-screen").should("be.visible");
  cy.getCy("intakeworkflow-title").should("be.visible");
  cy.getCy("intakeworkflow-content").should("be.visible");
  cy.getCy("intake-dashboard-referral-status").should("be.visible");
  cy.getCy("intake-dashboard-appointment-calendar").should("be.visible");
  cy.getCy("intake-dashboard-patient-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeWorkflowScreen successfully!\n");

  });
});
