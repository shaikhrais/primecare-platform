// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vendor_risk_assessor", () => {
  it("opens and verifies screen vendor_risk_assessor", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Vendor Risk Assessor)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Vendor Risk Assessor...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Vendor Risk Assessor...");
  cy.waitAndSee();
  cy.screenshot("vendor_risk_assessor");
  
  cy.task("log", "✅ PROGRESS: - Verified Vendor Risk Assessor successfully!\n");

  });
});
