// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_dashboard", () => {
  it("opens and verifies screen office_dashboard", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/office-dashboard (OfficeDashboardScreen)...");
  cy.visitWithSemantics("/common/office-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OfficeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");
  cy.getCy("office_dashboard-btn-add-task").should("be.visible");
  cy.getCy("office_dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("office_dashboard-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OfficeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("office_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified OfficeDashboardScreen successfully!\n");

  });
});
