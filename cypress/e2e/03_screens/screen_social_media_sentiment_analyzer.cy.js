// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_media_sentiment_analyzer", () => {
  it("opens and verifies screen social_media_sentiment_analyzer", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Social Media Sentiment Analyzer)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Social Media Sentiment Analyzer...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmediasentimentanalyzer-screen").should("be.visible");
  cy.getCy("socialmediasentimentanalyzer-title").should("be.visible");
  cy.getCy("socialmediasentimentanalyzer-content").should("be.visible");
  cy.getCy("socialmedia-sentiment-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Social Media Sentiment Analyzer...");
  cy.waitAndSee();
  cy.screenshot("social_media_sentiment_analyzer");
  
  cy.task("log", "✅ PROGRESS: - Verified Social Media Sentiment Analyzer successfully!\n");

  });
});
