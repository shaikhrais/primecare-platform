// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ai_chatbot", () => {
  it("opens and verifies screen ai_chatbot", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Ai Chatbot)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ai Chatbot...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ai Chatbot...");
  cy.waitAndSee();
  cy.screenshot("ai_chatbot");
  
  cy.task("log", "✅ PROGRESS: - Verified Ai Chatbot successfully!\n");

  });
});
