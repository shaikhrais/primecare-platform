// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - scrum_master", () => {
  it("tests all screens for role scrum_master", () => {
    cy.loginAsRole("scrum_master");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart (ScrumMasterDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for ScrumMasterDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for ScrumMasterDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified ScrumMasterDashboardScreen successfully!\n");

  });
});
