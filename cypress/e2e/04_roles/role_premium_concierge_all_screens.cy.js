// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - premium_concierge", () => {
  it("tests all screens for role premium_concierge", () => {
    cy.loginAsRole("premium_concierge");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart (PremiumConciergeDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for PremiumConciergeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergedashboard-screen").should("be.visible");
  cy.getCy("premiumconciergedashboard-title").should("be.visible");
  cy.getCy("premiumconciergedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for PremiumConciergeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("premium_concierge_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified PremiumConciergeDashboardScreen successfully!\n");

  });
});
