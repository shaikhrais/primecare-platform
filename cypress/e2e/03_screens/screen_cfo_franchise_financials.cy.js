// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_franchise_financials", () => {
  it("opens and verifies screen cfo_franchise_financials", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/franchise-financials (Cfo Franchise Financials)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/franchise-financials");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Franchise Financials...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfofranchisefinancials-screen").should("be.visible");
  cy.getCy("cfofranchisefinancials-title").should("be.visible");
  cy.getCy("cfofranchisefinancials-content").should("be.visible");
  cy.getCy("franchise-financials-btn-generate-report").should("be.visible");
  cy.getCy("franchise-financials-btn-send-message").should("be.visible");
  cy.getCy("franchise-financials-btn-review-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Franchise Financials...");
  cy.waitAndSee();
  cy.screenshot("cfo_franchise_financials");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Franchise Financials successfully!\n");

  });
});
