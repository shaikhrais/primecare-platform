// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_profile", () => {
  it("opens and verifies screen psw_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswprofile-screen").should("be.visible");
  cy.getCy("pswprofile-title").should("be.visible");
  cy.getCy("pswprofile-content").should("be.visible");
  cy.getCy("pswprofile-btn-edit").should("be.visible");
  cy.getCy("pswprofile-btn-update-password").should("be.visible");
  cy.getCy("pswprofile-btn-save").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Profile...");
  cy.waitAndSee();
  cy.screenshot("psw_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Profile successfully!\n");

  });
});
