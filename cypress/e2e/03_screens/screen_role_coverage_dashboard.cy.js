// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - role_coverage_dashboard", () => {
  it("opens and verifies screen role_coverage_dashboard", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RoleCoverageDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RoleCoverageDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified RoleCoverageDashboardScreen successfully!\n");

  });
});
