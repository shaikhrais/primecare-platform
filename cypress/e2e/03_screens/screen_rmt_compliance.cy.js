// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_compliance", () => {
  it("opens and verifies screen rmt_compliance", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/compliance (RmtComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcompliance-screen").should("be.visible");
  cy.getCy("rmtcompliance-title").should("be.visible");
  cy.getCy("rmtcompliance-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-appointments").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rmt-dashboard-client-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtComplianceScreen successfully!\n");

  });
});
