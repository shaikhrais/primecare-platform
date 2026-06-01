// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_tax_and_remittance", () => {
  it("opens and verifies screen cfo_tax_and_remittance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Cfo Tax And Remittance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Tax And Remittance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Tax And Remittance...");
  cy.waitAndSee();
  cy.screenshot("cfo_tax_and_remittance");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Tax And Remittance successfully!\n");

  });
});
