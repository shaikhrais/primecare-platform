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

  cy.getCy("aichatbot-screen").should("be.visible");
  cy.getCy("aichatbot-title").should("be.visible");
  cy.getCy("aichatbot-content").should("be.visible");
  cy.getCy("ai_chatbot-performance-metrics").should("be.visible");
  cy.getCy("ai_chatbot-user-engagement").should("be.visible");
  cy.getCy("ai_chatbot-error-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ai Chatbot...");
  cy.waitAndSee();
  cy.screenshot("ai_chatbot");
  
  cy.task("log", "✅ PROGRESS: - Verified Ai Chatbot successfully!\n");

  });
});
