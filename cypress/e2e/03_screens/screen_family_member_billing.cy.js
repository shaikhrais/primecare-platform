// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_billing", () => {
  it("opens and verifies screen family_member_billing", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Member Billing)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Member Billing...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberbilling-screen").should("be.visible");
  cy.getCy("familymemberbilling-title").should("be.visible");
  cy.getCy("familymemberbilling-content").should("be.visible");
  cy.getCy("billing-overview-card").should("be.visible");
  cy.getCy("payment-method-update-btn").should("be.visible");
  cy.getCy("billing-history-view-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Member Billing...");
  cy.waitAndSee();
  cy.screenshot("family_member_billing");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Member Billing successfully!\n");

  });
});
