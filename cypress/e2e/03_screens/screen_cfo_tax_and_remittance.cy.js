// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_tax_and_remittance", () => {
  it("opens and verifies screen cfo_tax_and_remittance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/tax-and-remittance (Cfo Tax And Remittance)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/tax-and-remittance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Tax And Remittance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotaxandremittance-screen").should("be.visible");
  cy.getCy("cfotaxandremittance-title").should("be.visible");
  cy.getCy("cfotaxandremittance-content").should("be.visible");
  cy.getCy("taxdata-review-widget").should("be.visible");
  cy.getCy("compliance-status-indicator").should("be.visible");
  cy.getCy("taxreport-generator-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Tax And Remittance...");
  cy.waitAndSee();
  cy.screenshot("cfo_tax_and_remittance");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Tax And Remittance successfully!\n");

  });
});
