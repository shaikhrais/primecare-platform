// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_compliance", () => {
  it("opens and verifies screen finance_director_compliance", () => {
    cy.loginAsRole("finance_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/finance-director-compliance (FinanceDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/finance-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FinanceDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FinanceDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified FinanceDirectorComplianceScreen successfully!\n");

  });
});
