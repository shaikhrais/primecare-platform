// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - lpn", () => {
  it("tests all screens for role lpn", () => {
    cy.loginAsRole("lpn");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /clinical/lpn-dashboard (LpnDashboardScreen)...");
  cy.visitWithSemantics("/clinical/lpn-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for LpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for LpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified LpnDashboardScreen successfully!\n");

  });
});
