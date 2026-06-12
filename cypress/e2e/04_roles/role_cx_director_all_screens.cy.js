// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cx_director", () => {
  it("tests all screens for role cx_director", () => {
    cy.loginAsRole("cx_director");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/corporate/roles/cx_director/dashboard (CxDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cx_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for CxDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for CxDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified CxDirectorDashboardScreen successfully!\n");

  });
});
