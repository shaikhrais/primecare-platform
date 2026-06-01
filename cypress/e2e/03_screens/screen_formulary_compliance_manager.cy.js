// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - formulary_compliance_manager", () => {
  it("opens and verifies screen formulary_compliance_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Formulary Compliance Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Formulary Compliance Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Formulary Compliance Manager...");
  cy.waitAndSee();
  cy.screenshot("formulary_compliance_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified Formulary Compliance Manager successfully!\n");

  });
});
