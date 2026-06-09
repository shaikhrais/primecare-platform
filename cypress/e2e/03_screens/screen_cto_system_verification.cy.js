// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_system_verification", () => {
  it("opens and verifies screen cto_system_verification", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/system-verification (Cto System Verification)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/system-verification");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto System Verification...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctosystemverification-screen").should("be.visible");
  cy.getCy("ctosystemverification-title").should("be.visible");
  cy.getCy("ctosystemverification-content").should("be.visible");
  cy.getCy("cto-system-verification-loading").should("be.visible");
  cy.getCy("cto-system-verification-error-log").should("be.visible");
  cy.getCy("cto-system-verification-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto System Verification...");
  cy.waitAndSee();
  cy.screenshot("cto_system_verification");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto System Verification successfully!\n");

  });
});
