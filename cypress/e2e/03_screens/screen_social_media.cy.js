// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_media", () => {
  it("opens and verifies screen social_media", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/social-media (SocialMediaScreen)...");
  cy.visitWithSemantics("/management/social-media");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SocialMediaScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmedia-screen").should("be.visible");
  cy.getCy("socialmedia-title").should("be.visible");
  cy.getCy("socialmedia-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-view-campaign").should("be.visible");
  cy.getCy("marketing-dashboard-btn-export-reports").should("be.visible");
  cy.getCy("marketing-dashboard-btn-analyze-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SocialMediaScreen...");
  cy.waitAndSee();
  cy.screenshot("social_media");
  
  cy.task("log", "✅ PROGRESS: - Verified SocialMediaScreen successfully!\n");

  });
});
