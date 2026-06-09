// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - surgical_video_archive", () => {
  it("opens and verifies screen surgical_video_archive", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Surgical Video Archive)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Surgical Video Archive...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("surgicalvideoarchive-screen").should("be.visible");
  cy.getCy("surgicalvideoarchive-title").should("be.visible");
  cy.getCy("surgicalvideoarchive-content").should("be.visible");
  cy.getCy("surgical-video-archive-refresh").should("be.visible");
  cy.getCy("surgical-video-archive-upload").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Surgical Video Archive...");
  cy.waitAndSee();
  cy.screenshot("surgical_video_archive");
  
  cy.task("log", "✅ PROGRESS: - Verified Surgical Video Archive successfully!\n");

  });
});
