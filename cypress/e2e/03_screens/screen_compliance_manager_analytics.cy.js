// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_analytics", () => {
  it("opens and verifies screen compliance_manager_analytics", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/compliance-manager-analytics (ComplianceManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ComplianceManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanageranalytics-screen").should("be.visible");
  cy.getCy("compliancemanageranalytics-title").should("be.visible");
  cy.getCy("compliancemanageranalytics-content").should("be.visible");
  cy.getCy("compliance-violation-tracker").should("be.visible");
  cy.getCy("audit-results-overview").should("be.visible");
  cy.getCy("training-participation-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ComplianceManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified ComplianceManagerAnalyticsScreen successfully!\n");

  });
});
