// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - employee", () => {
  it("tests all screens for role employee", () => {
    cy.loginAsRole("employee");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /staff/employee-dashboard (EmployeeDashboardScreen)...");
  cy.visitWithSemantics("/staff/employee-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for EmployeeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");
  cy.getCy("employee-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("employee-dashboard-btn-sync-security-posture").should("be.visible");
  cy.getCy("employee-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for EmployeeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified EmployeeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /staff/employee-analytics (Employee Analytics)...");
  cy.visitWithSemantics("/staff/employee-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Employee Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeeanalytics-screen").should("be.visible");
  cy.getCy("employeeanalytics-title").should("be.visible");
  cy.getCy("employeeanalytics-content").should("be.visible");
  cy.getCy("employee-analytics-btn-execute-scan").should("be.visible");
  cy.getCy("employee-analytics-btn-refresh-telemetry").should("be.visible");
  cy.getCy("employee-analytics-btn-trigger-governance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Employee Analytics...");
  cy.waitAndSee();
  cy.screenshot("employee_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Employee Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /staff/employee-workflow (Employee Compliance Workflow)...");
  cy.visitWithSemantics("/staff/employee-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Employee Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeeworkflow-screen").should("be.visible");
  cy.getCy("employeeworkflow-title").should("be.visible");
  cy.getCy("employeeworkflow-content").should("be.visible");
  cy.getCy("employee-workflow-btn-execute-scan").should("be.visible");
  cy.getCy("employee-workflow-btn-trigger-action").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Employee Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("employee_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Employee Compliance Workflow successfully!\n");

  });
});
