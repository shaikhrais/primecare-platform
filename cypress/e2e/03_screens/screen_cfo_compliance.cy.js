// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_compliance", () => {
  it("opens and verifies screen cfo_compliance", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-compliance (CfoComplianceScreen)...");
  cy.visitWithSemantics("/executive/cfo-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocompliance-screen").should("be.visible");
  cy.getCy("cfocompliance-title").should("be.visible");
  cy.getCy("cfocompliance-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("cfo-dashboard-financial-health").should("be.visible");
  cy.getCy("cfo-dashboard-budget-actual").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoComplianceScreen successfully!\n");

  });
});
