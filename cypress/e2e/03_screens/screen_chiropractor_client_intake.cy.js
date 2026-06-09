// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_client_intake", () => {
  it("opens and verifies screen chiropractor_client_intake", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");
  cy.getCy("chiropractor-btn-submit-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-review-history").should("be.visible");
  cy.getCy("chiropractor-btn-perform-examination").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorClientIntakeScreen successfully!\n");

  });
});
