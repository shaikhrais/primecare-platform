// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_analytics", () => {
  it("opens and verifies screen rn_analytics", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-analytics (RnAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnanalytics-screen").should("be.visible");
  cy.getCy("rnanalytics-title").should("be.visible");
  cy.getCy("rnanalytics-content").should("be.visible");
  cy.getCy("rn-dashboard-mmse-score").should("be.visible");
  cy.getCy("rn-dashboard-completed-intakes").should("be.visible");
  cy.getCy("rn-dashboard-active-care-plans").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified RnAnalyticsScreen successfully!\n");

  });
});
