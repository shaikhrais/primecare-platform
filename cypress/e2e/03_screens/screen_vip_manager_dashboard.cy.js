// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vip_manager_dashboard", () => {
  it("opens and verifies screen vip_manager_dashboard", () => {
    cy.loginAsRole("vip_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/vip-manager-dashboard (VipManagerDashboardScreen)...");
  cy.visitWithSemantics("/management/vip-manager-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified VipManagerDashboardScreen successfully!\n");

  });
});
