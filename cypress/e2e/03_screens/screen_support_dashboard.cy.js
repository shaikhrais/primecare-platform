// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - support_dashboard", () => {
  it("opens and verifies screen support_dashboard", () => {
    cy.loginAsRole("dynamic");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/support-dashboard (SupportDashboardScreen)...");
  cy.visitWithSemantics("/common/support-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("support_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified SupportDashboardScreen successfully!\n");

  });
});
