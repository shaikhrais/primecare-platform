// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_partners", () => {
  it("opens and verifies screen regional_bdm_partners", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/partners (Regional Bdm Partners)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/partners");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Partners...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmpartners-screen").should("be.visible");
  cy.getCy("regionalbdmpartners-title").should("be.visible");
  cy.getCy("regionalbdmpartners-content").should("be.visible");
  cy.getCy("bdm-dashboard-kpi").should("be.visible");
  cy.getCy("bdm-dashboard-engagement-trend").should("be.visible");
  cy.getCy("bdm-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Partners...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_partners");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Partners successfully!\n");

  });
});
