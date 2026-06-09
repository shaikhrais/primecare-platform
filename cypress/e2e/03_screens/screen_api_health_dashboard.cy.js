// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - api_health_dashboard", () => {
  it("opens and verifies screen api_health_dashboard", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/api-health-dashboard (ApiHealthDashboardScreen)...");
  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ApiHealthDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ApiHealthDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ApiHealthDashboardScreen successfully!\n");

  });
});
