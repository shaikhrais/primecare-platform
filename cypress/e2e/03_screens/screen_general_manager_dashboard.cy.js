// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_dashboard", () => {
  it("opens and verifies screen general_manager_dashboard", () => {
    cy.loginAsRole("gm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/general_manager/dashboard (GeneralManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/general_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GeneralManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");
  cy.getCy("gm-dashboard-kpi").should("be.visible");
  cy.getCy("gm-dashboard-operational-metrics").should("be.visible");
  cy.getCy("gm-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GeneralManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified GeneralManagerDashboardScreen successfully!\n");

  });
});
