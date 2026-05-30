// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - tax_compliance", () => {
  it("opens and verifies screen tax_compliance", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/tax-compliance (TaxComplianceScreen)...");
  cy.visitWithSemantics("/executive/tax-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TaxComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("taxcompliance-screen").should("be.visible");
  cy.getCy("taxcompliance-title").should("be.visible");
  cy.getCy("taxcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TaxComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("tax_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified TaxComplianceScreen successfully!\n");

  });
});
