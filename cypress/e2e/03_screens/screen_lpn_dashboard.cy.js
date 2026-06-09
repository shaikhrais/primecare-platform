// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lpn_dashboard", () => {
  it("opens and verifies screen lpn_dashboard", () => {
    cy.loginAsRole("lpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/lpn-dashboard (LpnDashboardScreen)...");
  cy.visitWithSemantics("/clinical/lpn-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");
  cy.getCy("lpn-dashboard-vital-signs").should("be.visible");
  cy.getCy("lpn-dashboard-medication-log").should("be.visible");
  cy.getCy("lpn-dashboard-compliance-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified LpnDashboardScreen successfully!\n");

  });
});
