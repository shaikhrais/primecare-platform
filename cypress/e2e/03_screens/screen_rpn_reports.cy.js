// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_reports", () => {
  it("opens and verifies screen rpn_reports", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnreports-screen").should("be.visible");
  cy.getCy("rpnreports-title").should("be.visible");
  cy.getCy("rpnreports-content").should("be.visible");
  cy.getCy("rpn-dashboard-vital-signs").should("be.visible");
  cy.getCy("rpn-dashboard-medication-records").should("be.visible");
  cy.getCy("rpn-dashboard-documentation-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnReportsScreen successfully!\n");

  });
});
