// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - asynchronous_consultation_inbox", () => {
  it("opens and verifies screen asynchronous_consultation_inbox", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Asynchronous Consultation Inbox)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Asynchronous Consultation Inbox...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Asynchronous Consultation Inbox...");
  cy.waitAndSee();
  cy.screenshot("asynchronous_consultation_inbox");
  
  cy.task("log", "✅ PROGRESS: - Verified Asynchronous Consultation Inbox successfully!\n");

  });
});
