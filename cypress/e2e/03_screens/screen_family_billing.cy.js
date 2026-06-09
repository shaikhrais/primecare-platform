// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_billing", () => {
  it("opens and verifies screen family_billing", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/family_member/billing (Family Billing)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/billing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Billing...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familybilling-screen").should("be.visible");
  cy.getCy("familybilling-title").should("be.visible");
  cy.getCy("familybilling-content").should("be.visible");
  cy.getCy("billing-summary-card").should("be.visible");
  cy.getCy("billing-notification-panel").should("be.visible");
  cy.getCy("billing-history-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Billing...");
  cy.waitAndSee();
  cy.screenshot("family_billing");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Billing successfully!\n");

  });
});
