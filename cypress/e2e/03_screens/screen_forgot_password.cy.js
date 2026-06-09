// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - forgot_password", () => {
  it("opens and verifies screen forgot_password", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Forgot Password)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Forgot Password...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("forgotpassword-screen").should("be.visible");
  cy.getCy("forgotpassword-title").should("be.visible");
  cy.getCy("forgotpassword-content").should("be.visible");
  cy.getCy("forgot-password-email-input").should("be.visible");
  cy.getCy("forgot-password-send-button").should("be.visible");
  cy.getCy("forgot-password-status-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Forgot Password...");
  cy.waitAndSee();
  cy.screenshot("forgot_password");
  
  cy.task("log", "✅ PROGRESS: - Verified Forgot Password successfully!\n");

  });
});
