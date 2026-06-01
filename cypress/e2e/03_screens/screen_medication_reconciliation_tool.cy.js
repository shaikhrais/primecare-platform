// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medication_reconciliation_tool", () => {
  it("opens and verifies screen medication_reconciliation_tool", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Medication Reconciliation Tool)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Medication Reconciliation Tool...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Medication Reconciliation Tool...");
  cy.waitAndSee();
  cy.screenshot("medication_reconciliation_tool");
  
  cy.task("log", "✅ PROGRESS: - Verified Medication Reconciliation Tool successfully!\n");

  });
});
