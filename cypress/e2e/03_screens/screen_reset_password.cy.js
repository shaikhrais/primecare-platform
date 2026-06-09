// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - reset_password", () => {
  it("opens and verifies screen reset_password", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Reset Password)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Reset Password...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("resetpassword-screen").should("be.visible");
  cy.getCy("resetpassword-title").should("be.visible");
  cy.getCy("resetpassword-content").should("be.visible");
  cy.getCy("reset-password-new-password").should("be.visible");
  cy.getCy("reset-password-confirm-password").should("be.visible");
  cy.getCy("reset-password-update-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Reset Password...");
  cy.waitAndSee();
  cy.screenshot("reset_password");
  
  cy.task("log", "✅ PROGRESS: - Verified Reset Password successfully!\n");

  });
});
