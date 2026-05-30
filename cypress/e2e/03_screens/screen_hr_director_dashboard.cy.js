// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_dashboard", () => {
  it("opens and verifies screen hr_director_dashboard", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/hr-director-dashboard (HrDirectorDashboardScreen)...");
  cy.visitWithSemantics("/executive/hr-director-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified HrDirectorDashboardScreen successfully!\n");

  });
});
