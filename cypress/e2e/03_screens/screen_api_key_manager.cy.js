// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - api_key_manager", () => {
  it("opens and verifies screen api_key_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Api Key Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Api Key Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apikeymanager-screen").should("be.visible");
  cy.getCy("apikeymanager-title").should("be.visible");
  cy.getCy("apikeymanager-content").should("be.visible");
  cy.getCy("api-key-manager-btn-generate").should("be.visible");
  cy.getCy("api-key-manager-btn-rotate").should("be.visible");
  cy.getCy("api-key-manager-btn-revoke").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Api Key Manager...");
  cy.waitAndSee();
  cy.screenshot("api_key_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified Api Key Manager successfully!\n");

  });
});
