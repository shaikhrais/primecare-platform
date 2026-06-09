// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_compliance", () => {
  it("opens and verifies screen franchise_compliance", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/franchise-compliance (FranchiseComplianceScreen)...");
  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");
  cy.getCy("franchise-compliance-status-indicator").should("be.visible");
  cy.getCy("franchise-audit-log-viewer").should("be.visible");
  cy.getCy("franchise-compliance-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseComplianceScreen successfully!\n");

  });
});
