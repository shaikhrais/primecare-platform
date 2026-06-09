// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - consent", () => {
  it("opens and verifies screen consent", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Consent)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Consent...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("consent-screen").should("be.visible");
  cy.getCy("consent-title").should("be.visible");
  cy.getCy("consent-content").should("be.visible");
  cy.getCy("consent-btn-login").should("be.visible");
  cy.getCy("consent-btn-signout").should("be.visible");
  cy.getCy("consent-btn-continue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Consent...");
  cy.waitAndSee();
  cy.screenshot("consent");
  
  cy.task("log", "✅ PROGRESS: - Verified Consent successfully!\n");

  });
});
