// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_franchise_pipeline", () => {
  it("opens and verifies screen regional_bdm_franchise_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/franchise-pipeline (Regional Bdm Franchise Pipeline)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/franchise-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Franchise Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmfranchisepipeline-screen").should("be.visible");
  cy.getCy("regionalbdmfranchisepipeline-title").should("be.visible");
  cy.getCy("regionalbdmfranchisepipeline-content").should("be.visible");
  cy.getCy("franchise-pipeline-chart").should("be.visible");
  cy.getCy("kpi-widget").should("be.visible");
  cy.getCy("alert-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Franchise Pipeline...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_franchise_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Franchise Pipeline successfully!\n");

  });
});
