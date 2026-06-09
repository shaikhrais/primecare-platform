// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_workflow", () => {
  it("opens and verifies screen office_workflow", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/office-workflow (OfficeWorkflowScreen)...");
  cy.visitWithSemantics("/common/office-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OfficeWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeworkflow-screen").should("be.visible");
  cy.getCy("officeworkflow-title").should("be.visible");
  cy.getCy("officeworkflow-content").should("be.visible");
  cy.getCy("officeworkflow-btn-add-appointment").should("be.visible");
  cy.getCy("officeworkflow-btn-complete-task").should("be.visible");
  cy.getCy("officeworkflow-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OfficeWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("office_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified OfficeWorkflowScreen successfully!\n");

  });
});
