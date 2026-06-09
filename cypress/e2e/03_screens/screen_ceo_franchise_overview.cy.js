// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_franchise_overview", () => {
  it("opens and verifies screen ceo_franchise_overview", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/franchise-overview (Ceo Franchise Overview)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/franchise-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Franchise Overview...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceofranchiseoverview-screen").should("be.visible");
  cy.getCy("ceofranchiseoverview-title").should("be.visible");
  cy.getCy("ceofranchiseoverview-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("franchise-dashboard-btn-send-update").should("be.visible");
  cy.getCy("franchise-dashboard-btn-analyze-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Franchise Overview...");
  cy.waitAndSee();
  cy.screenshot("ceo_franchise_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Franchise Overview successfully!\n");

  });
});
