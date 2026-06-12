// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rpn", () => {
  it("tests all screens for role rpn", () => {
    cy.loginAsRole("rpn");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for RpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpndashboard-screen").should("be.visible");
  cy.getCy("rpndashboard-title").should("be.visible");
  cy.getCy("rpndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for RpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified RpnDashboardScreen successfully!\n");

  });
});
