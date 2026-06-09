// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infrastructure_dashboard", () => {
  it("opens and verifies screen infrastructure_dashboard", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/infrastructure-dashboard (InfrastructureDashboardScreen)...");
  cy.visitWithSemantics("/common/infrastructure-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for InfrastructureDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructuredashboard-screen").should("be.visible");
  cy.getCy("infrastructuredashboard-title").should("be.visible");
  cy.getCy("infrastructuredashboard-content").should("be.visible");
  cy.getCy("infrastructure-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("infrastructure-dashboard-btn-sync-posture").should("be.visible");
  cy.getCy("infrastructure-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for InfrastructureDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified InfrastructureDashboardScreen successfully!\n");

  });
});
