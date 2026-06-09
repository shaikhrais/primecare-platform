// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_workflow", () => {
  it("opens and verifies screen receptionist_workflow", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/receptionist-workflow (ReceptionistWorkflowScreen)...");
  cy.visitWithSemantics("/staff/receptionist-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ReceptionistWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistworkflow-screen").should("be.visible");
  cy.getCy("receptionistworkflow-title").should("be.visible");
  cy.getCy("receptionistworkflow-content").should("be.visible");
  cy.getCy("admin-dashboard-btn-logcall").should("be.visible");
  cy.getCy("admin-dashboard-btn-schedule").should("be.visible");
  cy.getCy("admin-dashboard-btn-sendemail").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ReceptionistWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ReceptionistWorkflowScreen successfully!\n");

  });
});
