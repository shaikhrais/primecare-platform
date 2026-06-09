// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - np_dashboard", () => {
  it("opens and verifies screen np_dashboard", () => {
    cy.loginAsRole("np");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/np-dashboard (NpDashboardScreen)...");
  cy.visitWithSemantics("/clinical/np-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for NpDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npdashboard-screen").should("be.visible");
  cy.getCy("npdashboard-title").should("be.visible");
  cy.getCy("npdashboard-content").should("be.visible");
  cy.getCy("npdashboard-btn-view-records").should("be.visible");
  cy.getCy("npdashboard-btn-log-activity").should("be.visible");
  cy.getCy("npdashboard-btn-send-referral").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for NpDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("np_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified NpDashboardScreen successfully!\n");

  });
});
