// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - login", () => {
  it("opens and verifies screen login", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Login)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Login...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("login-screen").should("be.visible");
  cy.getCy("login-title").should("be.visible");
  cy.getCy("login-content").should("be.visible");
  cy.getCy("login-email-input").should("be.visible");
  cy.getCy("login-password-input").should("be.visible");
  cy.getCy("login-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Login...");
  cy.waitAndSee();
  cy.screenshot("login");
  
  cy.task("log", "✅ PROGRESS: - Verified Login successfully!\n");

  });
});
