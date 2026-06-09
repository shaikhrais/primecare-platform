// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_compliance", () => {
  it("opens and verifies screen portal_compliance", () => {
    cy.loginAsRole("portal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/portal-compliance (PortalComplianceScreen)...");
  cy.visitWithSemantics("/common/portal-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PortalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalcompliance-screen").should("be.visible");
  cy.getCy("portalcompliance-title").should("be.visible");
  cy.getCy("portalcompliance-content").should("be.visible");
  cy.getCy("portal-compliance-btn-execute-audit").should("be.visible");
  cy.getCy("portal-compliance-btn-trigger-action").should("be.visible");
  cy.getCy("portal-compliance-btn-manage-directives").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PortalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified PortalComplianceScreen successfully!\n");

  });
});
