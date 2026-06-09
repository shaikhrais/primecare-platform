// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_compliance", () => {
  it("opens and verifies screen cto_compliance", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cto-compliance (CtoComplianceScreen)...");
  cy.visitWithSemantics("/executive/cto-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CtoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctocompliance-screen").should("be.visible");
  cy.getCy("ctocompliance-title").should("be.visible");
  cy.getCy("ctocompliance-content").should("be.visible");
  cy.getCy("cto-dashboard-btn-refresh").should("be.visible");
  cy.getCy("cto-dashboard-btn-audit-logs").should("be.visible");
  cy.getCy("cto-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CtoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CtoComplianceScreen successfully!\n");

  });
});
