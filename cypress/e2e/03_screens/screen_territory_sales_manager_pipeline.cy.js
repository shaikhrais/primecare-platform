// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_pipeline", () => {
  it("opens and verifies screen territory_sales_manager_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Pipeline)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerpipeline-screen").should("be.visible");
  cy.getCy("territorysalesmanagerpipeline-title").should("be.visible");
  cy.getCy("territorysalesmanagerpipeline-content").should("be.visible");
  cy.getCy("salespipeline-overview").should("be.visible");
  cy.getCy("territory-performance-metrics").should("be.visible");
  cy.getCy("leads-opportunities-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Pipeline...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Pipeline successfully!\n");

  });
});
