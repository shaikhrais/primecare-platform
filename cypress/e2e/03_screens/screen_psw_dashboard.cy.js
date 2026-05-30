// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_dashboard", () => {
  it("opens and verifies screen psw_dashboard", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PswDashboardScreen successfully!\n");

  });
});
