// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_compliance", () => {
  it("opens and verifies screen rn_compliance", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-compliance (RnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncompliance-screen").should("be.visible");
  cy.getCy("rncompliance-title").should("be.visible");
  cy.getCy("rncompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified RnComplianceScreen successfully!\n");

  });
});
