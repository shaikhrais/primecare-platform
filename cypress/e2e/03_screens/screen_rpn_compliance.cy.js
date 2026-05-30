// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_compliance", () => {
  it("opens and verifies screen rpn_compliance", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncompliance-screen").should("be.visible");
  cy.getCy("rpncompliance-title").should("be.visible");
  cy.getCy("rpncompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnComplianceScreen successfully!\n");

  });
});
