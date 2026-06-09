// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_analytics", () => {
  it("opens and verifies screen physiotherapist_analytics", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/analytics (PhysiotherapistAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistanalytics-screen").should("be.visible");
  cy.getCy("physiotherapistanalytics-title").should("be.visible");
  cy.getCy("physiotherapistanalytics-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-save").should("be.visible");
  cy.getCy("physio-dashboard-btn-update").should("be.visible");
  cy.getCy("physio-dashboard-btn-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistAnalyticsScreen successfully!\n");

  });
});
