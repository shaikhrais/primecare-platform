// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_manager_dashboard", () => {
  it("opens and verifies screen hr_manager_dashboard", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/hr_manager/dashboard (HrManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-reports").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified HrManagerDashboardScreen successfully!\n");

  });
});
