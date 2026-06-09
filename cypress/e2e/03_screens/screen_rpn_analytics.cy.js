// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_analytics", () => {
  it("opens and verifies screen rpn_analytics", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-analytics (RpnAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnanalytics-screen").should("be.visible");
  cy.getCy("rpnanalytics-title").should("be.visible");
  cy.getCy("rpnanalytics-content").should("be.visible");
  cy.getCy("rpn-dashboard-log-vital-signs").should("be.visible");
  cy.getCy("rpn-dashboard-administer-immunization").should("be.visible");
  cy.getCy("rpn-dashboard-update-wound-care").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnAnalyticsScreen successfully!\n");

  });
});
