// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_dashboard", () => {
  it("opens and verifies screen finance_director_dashboard", () => {
    cy.loginAsRole("finance_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/finance-director-dashboard (FinanceDirectorDashboardScreen)...");
  cy.visitWithSemantics("/executive/finance-director-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FinanceDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FinanceDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified FinanceDirectorDashboardScreen successfully!\n");

  });
});
