// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_compliance", () => {
  it("opens and verifies screen partnership_manager_compliance", () => {
    cy.loginAsRole("partnership");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/partnership-manager-compliance (PartnershipManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PartnershipManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagercompliance-screen").should("be.visible");
  cy.getCy("partnershipmanagercompliance-title").should("be.visible");
  cy.getCy("partnershipmanagercompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status-card").should("be.visible");
  cy.getCy("recent-audit-summary-card").should("be.visible");
  cy.getCy("operational-logs-table").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PartnershipManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified PartnershipManagerComplianceScreen successfully!\n");

  });
});
