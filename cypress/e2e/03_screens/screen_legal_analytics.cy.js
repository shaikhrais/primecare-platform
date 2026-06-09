// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - legal_analytics", () => {
  it("opens and verifies screen legal_analytics", () => {
    cy.loginAsRole("legal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/legal-analytics (LegalAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/legal-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LegalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalanalytics-screen").should("be.visible");
  cy.getCy("legalanalytics-title").should("be.visible");
  cy.getCy("legalanalytics-content").should("be.visible");
  cy.getCy("legal-dashboard-kpi-chart").should("be.visible");
  cy.getCy("legal-dashboard-litigation-status").should("be.visible");
  cy.getCy("legal-dashboard-compliance-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LegalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified LegalAnalyticsScreen successfully!\n");

  });
});
