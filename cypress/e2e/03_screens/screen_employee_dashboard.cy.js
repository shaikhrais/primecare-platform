// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_dashboard", () => {
  it("opens and verifies screen employee_dashboard", () => {
    cy.loginAsRole("employee");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/employee-dashboard (EmployeeDashboardScreen)...");
  cy.visitWithSemantics("/staff/employee-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for EmployeeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");
  cy.getCy("employee-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("employee-dashboard-btn-sync-security-posture").should("be.visible");
  cy.getCy("employee-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for EmployeeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified EmployeeDashboardScreen successfully!\n");

  });
});
