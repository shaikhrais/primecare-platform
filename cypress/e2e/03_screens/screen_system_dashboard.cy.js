// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_dashboard", () => {
  it("opens and verifies screen system_dashboard", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-dashboard (SystemDashboardScreen)...");
  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemDashboardScreen successfully!\n");

  });
});
