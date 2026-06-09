// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_analytics", () => {
  it("opens and verifies screen governance_officer_analytics", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/governance-officer-analytics (GovernanceOfficerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/governance-officer-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GovernanceOfficerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-send-alert").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GovernanceOfficerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified GovernanceOfficerAnalyticsScreen successfully!\n");

  });
});
