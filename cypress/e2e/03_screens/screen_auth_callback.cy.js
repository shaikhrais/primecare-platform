// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - auth_callback", () => {
  it("opens and verifies screen auth_callback", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Auth Callback)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Auth Callback...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("authcallback-screen").should("be.visible");
  cy.getCy("authcallback-title").should("be.visible");
  cy.getCy("authcallback-content").should("be.visible");
  cy.getCy("auth-status-display").should("be.visible");
  cy.getCy("auth-error-display").should("be.visible");
  cy.getCy("auth-logs-display").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Auth Callback...");
  cy.waitAndSee();
  cy.screenshot("auth_callback");
  
  cy.task("log", "✅ PROGRESS: - Verified Auth Callback successfully!\n");

  });
});
