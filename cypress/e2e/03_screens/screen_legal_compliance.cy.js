// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - legal_compliance", () => {
  it("opens and verifies screen legal_compliance", () => {
    cy.loginAsRole("legal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/legal-compliance (LegalComplianceScreen)...");
  cy.visitWithSemantics("/executive/legal-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LegalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalcompliance-screen").should("be.visible");
  cy.getCy("legalcompliance-title").should("be.visible");
  cy.getCy("legalcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LegalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified LegalComplianceScreen successfully!\n");

  });
});
