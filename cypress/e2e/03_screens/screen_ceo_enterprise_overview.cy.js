// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_enterprise_overview", () => {
  it("opens and verifies screen ceo_enterprise_overview", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/enterprise-overview (Ceo Enterprise Overview)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/enterprise-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Enterprise Overview...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoenterpriseoverview-screen").should("be.visible");
  cy.getCy("ceoenterpriseoverview-title").should("be.visible");
  cy.getCy("ceoenterpriseoverview-content").should("be.visible");
  cy.getCy("dashboard-performance-metrics").should("be.visible");
  cy.getCy("dashboard-operational-indicators").should("be.visible");
  cy.getCy("dashboard-financial-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Enterprise Overview...");
  cy.waitAndSee();
  cy.screenshot("ceo_enterprise_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Enterprise Overview successfully!\n");

  });
});
