// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - gamification_profile", () => {
  it("opens and verifies screen gamification_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Gamification Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Gamification Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("gamificationprofile-screen").should("be.visible");
  cy.getCy("gamificationprofile-title").should("be.visible");
  cy.getCy("gamificationprofile-content").should("be.visible");
  cy.getCy("gamification-profile-btn-award-points").should("be.visible");
  cy.getCy("gamification-profile-btn-update-profile").should("be.visible");
  cy.getCy("gamification-profile-leaderboard-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Gamification Profile...");
  cy.waitAndSee();
  cy.screenshot("gamification_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Gamification Profile successfully!\n");

  });
});
