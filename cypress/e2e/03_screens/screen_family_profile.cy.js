// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_profile", () => {
  it("opens and verifies screen family_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/family_member/profile (Family Profile)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyprofile-screen").should("be.visible");
  cy.getCy("familyprofile-title").should("be.visible");
  cy.getCy("familyprofile-content").should("be.visible");
  cy.getCy("familyprofile-loading-indicator").should("be.visible");
  cy.getCy("familyprofile-error-notification").should("be.visible");
  cy.getCy("familyprofile-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Profile...");
  cy.waitAndSee();
  cy.screenshot("family_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Profile successfully!\n");

  });
});
