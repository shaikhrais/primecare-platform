// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_territory_growth", () => {
  it("opens and verifies screen regional_bdm_territory_growth", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/territory-growth (Regional Bdm Territory Growth)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/territory-growth");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Territory Growth...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmterritorygrowth-screen").should("be.visible");
  cy.getCy("regionalbdmterritorygrowth-title").should("be.visible");
  cy.getCy("regionalbdmterritorygrowth-content").should("be.visible");
  cy.getCy("regional-bdm-sales-metrics").should("be.visible");
  cy.getCy("regional-bdm-growth-trends").should("be.visible");
  cy.getCy("regional-bdm-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Territory Growth...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_territory_growth");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Territory Growth successfully!\n");

  });
});
