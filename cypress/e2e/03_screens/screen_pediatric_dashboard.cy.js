// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pediatric_dashboard", () => {
  it("opens and verifies screen pediatric_dashboard", () => {
    cy.loginAsRole("pediatric");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/pediatric-dashboard (PediatricDashboardScreen)...");
  cy.visitWithSemantics("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PediatricDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-record-growth").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-administer-vaccination").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-schedule-appointment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PediatricDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PediatricDashboardScreen successfully!\n");

  });
});
