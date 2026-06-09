// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_dashboard", () => {
  it("opens and verifies screen intake_dashboard", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");
  cy.getCy("intake-dashboard-active-requests").should("be.visible");
  cy.getCy("intake-dashboard-appointment-metrics").should("be.visible");
  cy.getCy("intake-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeDashboardScreen successfully!\n");

  });
});
