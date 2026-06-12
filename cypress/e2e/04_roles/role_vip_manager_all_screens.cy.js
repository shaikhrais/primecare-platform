// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - vip_manager", () => {
  it("tests all screens for role vip_manager", () => {
    cy.loginAsRole("vip_manager");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart (VipManagerDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for VipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for VipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified VipManagerDashboardScreen successfully!\n");

  });
});
