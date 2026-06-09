// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - sso_redirect", () => {
  it("opens and verifies screen sso_redirect", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Sso Redirect)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Sso Redirect...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ssoredirect-screen").should("be.visible");
  cy.getCy("ssoredirect-title").should("be.visible");
  cy.getCy("ssoredirect-content").should("be.visible");
  cy.getCy("sso-redirect-monitor").should("be.visible");
  cy.getCy("sso-error-log").should("be.visible");
  cy.getCy("sso-feedback-collector").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Sso Redirect...");
  cy.waitAndSee();
  cy.screenshot("sso_redirect");
  
  cy.task("log", "✅ PROGRESS: - Verified Sso Redirect successfully!\n");

  });
});
