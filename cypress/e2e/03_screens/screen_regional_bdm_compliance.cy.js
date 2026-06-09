// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_compliance", () => {
  it("opens and verifies screen regional_bdm_compliance", () => {
    cy.loginAsRole("regional_bdm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/regional-bdm-compliance (RegionalBdmComplianceScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RegionalBdmComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmcompliance-screen").should("be.visible");
  cy.getCy("regionalbdmcompliance-title").should("be.visible");
  cy.getCy("regionalbdmcompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status").should("be.visible");
  cy.getCy("telemetry-data-display").should("be.visible");
  cy.getCy("governance-actions-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RegionalBdmComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified RegionalBdmComplianceScreen successfully!\n");

  });
});
