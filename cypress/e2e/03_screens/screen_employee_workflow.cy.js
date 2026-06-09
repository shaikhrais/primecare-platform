// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_workflow", () => {
  it("opens and verifies screen employee_workflow", () => {
    cy.loginAsRole("employee");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/employee-workflow (Employee Compliance Workflow)...");
  cy.visitWithSemantics("/staff/employee-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Employee Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeeworkflow-screen").should("be.visible");
  cy.getCy("employeeworkflow-title").should("be.visible");
  cy.getCy("employeeworkflow-content").should("be.visible");
  cy.getCy("employee-workflow-btn-execute-scan").should("be.visible");
  cy.getCy("employee-workflow-btn-trigger-action").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Employee Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("employee_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Employee Compliance Workflow successfully!\n");

  });
});
