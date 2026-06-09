// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_attendance", () => {
  it("opens and verifies screen operations_manager_attendance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/attendance (Operations Manager Attendance)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/attendance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Attendance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerattendance-screen").should("be.visible");
  cy.getCy("operationsmanagerattendance-title").should("be.visible");
  cy.getCy("operationsmanagerattendance-content").should("be.visible");
  cy.getCy("attendance-overview-widget").should("be.visible");
  cy.getCy("attendance-alerts-widget").should("be.visible");
  cy.getCy("attendance-trends-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Attendance...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_attendance");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Attendance successfully!\n");

  });
});
