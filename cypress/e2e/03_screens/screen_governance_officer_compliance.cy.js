// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_compliance", () => {
  it("opens and verifies screen governance_officer_compliance", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GovernanceOfficerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");
  cy.getCy("govdashboard-btn-start-audit").should("be.visible");
  cy.getCy("govdashboard-btn-view-reports").should("be.visible");
  cy.getCy("govdashboard-btn-generate-training-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GovernanceOfficerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified GovernanceOfficerComplianceScreen successfully!\n");

  });
});
