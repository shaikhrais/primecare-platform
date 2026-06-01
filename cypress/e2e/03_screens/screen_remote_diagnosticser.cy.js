// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - remote_diagnosticser", () => {
  it("opens and verifies screen remote_diagnosticser", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Remote Diagnosticser)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Remote Diagnosticser...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Remote Diagnosticser...");
  cy.waitAndSee();
  cy.screenshot("remote_diagnosticser");
  
  cy.task("log", "✅ PROGRESS: - Verified Remote Diagnosticser successfully!\n");

  });
});
