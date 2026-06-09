// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_screen_dashboard", () => {
  it("opens and verifies screen dynamic_screen_dashboard", () => {
    cy.loginAsRole("guest");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/dynamic-dashboard (DynamicScreenDashboardScreen)...");
  cy.visitWithSemantics("/common/dynamic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DynamicScreenDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicscreendashboard-screen").should("be.visible");
  cy.getCy("dynamicscreendashboard-title").should("be.visible");
  cy.getCy("dynamicscreendashboard-content").should("be.visible");
  cy.getCy("dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("dashboard-btn-sync-security-posture").should("be.visible");
  cy.getCy("dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DynamicScreenDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_screen_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified DynamicScreenDashboardScreen successfully!\n");

  });
});
