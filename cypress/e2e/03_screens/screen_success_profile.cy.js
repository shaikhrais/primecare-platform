// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - success_profile", () => {
  it("opens and verifies screen success_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Success Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Success Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("successprofile-screen").should("be.visible");
  cy.getCy("successprofile-title").should("be.visible");
  cy.getCy("successprofile-content").should("be.visible");
  cy.getCy("user-auth-status-indicator").should("be.visible");
  cy.getCy("session-verification-status").should("be.visible");
  cy.getCy("user-details-display").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Success Profile...");
  cy.waitAndSee();
  cy.screenshot("success_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Success Profile successfully!\n");

  });
});
