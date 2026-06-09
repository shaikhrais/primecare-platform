// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_leads", () => {
  it("opens and verifies screen regional_bdm_leads", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/leads (Regional Bdm Leads)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/leads");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmleads-screen").should("be.visible");
  cy.getCy("regionalbdmleads-title").should("be.visible");
  cy.getCy("regionalbdmleads-content").should("be.visible");
  cy.getCy("lead-overview-card").should("be.visible");
  cy.getCy("performance-metrics-chart").should("be.visible");
  cy.getCy("lead-trends-visualization").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Leads...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_leads");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Leads successfully!\n");

  });
});
