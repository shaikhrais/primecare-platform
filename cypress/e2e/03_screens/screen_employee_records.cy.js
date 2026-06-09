// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_records", () => {
  it("opens and verifies screen employee_records", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/employee-records (EmployeeRecordsScreen)...");
  cy.visitWithSemantics("/management/employee-records");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for EmployeeRecordsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for EmployeeRecordsScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_records");
  
  cy.task("log", "✅ PROGRESS: - Verified EmployeeRecordsScreen successfully!\n");

  });
});
