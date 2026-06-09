// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_profile", () => {
  it("opens and verifies screen family_member_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Member Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Member Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberprofile-screen").should("be.visible");
  cy.getCy("familymemberprofile-title").should("be.visible");
  cy.getCy("familymemberprofile-content").should("be.visible");
  cy.getCy("family-member-profile-loading").should("be.visible");
  cy.getCy("family-member-profile-error").should("be.visible");
  cy.getCy("family-member-profile-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Member Profile...");
  cy.waitAndSee();
  cy.screenshot("family_member_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Member Profile successfully!\n");

  });
});
