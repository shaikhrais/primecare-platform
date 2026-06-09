// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - mfa", () => {
  it("opens and verifies screen mfa", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Mfa)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Mfa...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("mfa-screen").should("be.visible");
  cy.getCy("mfa-title").should("be.visible");
  cy.getCy("mfa-content").should("be.visible");
  cy.getCy("mfa-code-input").should("be.visible");
  cy.getCy("mfa-submit-button").should("be.visible");
  cy.getCy("mfa-verification-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Mfa...");
  cy.waitAndSee();
  cy.screenshot("mfa");
  
  cy.task("log", "✅ PROGRESS: - Verified Mfa successfully!\n");

  });
});
