// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_dashboard", () => {
  it("opens and verifies screen governance_officer_dashboard", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GovernanceOfficerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-execute-compliance-scan").should("be.visible");
  cy.getCy("govdashboard-btn-export-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GovernanceOfficerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified GovernanceOfficerDashboardScreen successfully!\n");

  });
});
