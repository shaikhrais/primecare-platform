// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_claims", () => {
  it("opens and verifies screen billing_claims", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Billing Claims)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Billing Claims...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingclaims-screen").should("be.visible");
  cy.getCy("billingclaims-title").should("be.visible");
  cy.getCy("billingclaims-content").should("be.visible");
  cy.getCy("billing-claims-btn-submit").should("be.visible");
  cy.getCy("billing-claims-btn-clear").should("be.visible");
  cy.getCy("billing-claims-btn-reconcile").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Billing Claims...");
  cy.waitAndSee();
  cy.screenshot("billing_claims");
  
  cy.task("log", "✅ PROGRESS: - Verified Billing Claims successfully!\n");

  });
});
