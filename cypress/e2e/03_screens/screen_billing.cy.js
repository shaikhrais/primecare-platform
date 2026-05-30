// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing", () => {
  it("opens and verifies screen billing", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/billing (BillingScreen)...");
  cy.visitWithSemantics("/common/billing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BillingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billing-screen").should("be.visible");
  cy.getCy("billing-title").should("be.visible");
  cy.getCy("billing-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BillingScreen...");
  cy.waitAndSee();
  cy.screenshot("billing");
  
  cy.task("log", "✅ PROGRESS: - Verified BillingScreen successfully!\n");

  });
});
