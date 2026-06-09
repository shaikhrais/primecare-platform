// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_verification_hub", () => {
  it("opens and verifies screen cto_verification_hub", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/verification-hub (Cto Verification Hub)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/verification-hub");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Verification Hub...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoverificationhub-screen").should("be.visible");
  cy.getCy("ctoverificationhub-title").should("be.visible");
  cy.getCy("ctoverificationhub-content").should("be.visible");
  cy.getCy("cto-verification-status").should("be.visible");
  cy.getCy("cto-verification-refresh").should("be.visible");
  cy.getCy("cto-verification-report-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Verification Hub...");
  cy.waitAndSee();
  cy.screenshot("cto_verification_hub");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Verification Hub successfully!\n");

  });
});
