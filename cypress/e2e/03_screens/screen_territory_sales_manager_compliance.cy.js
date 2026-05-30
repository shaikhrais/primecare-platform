// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_compliance", () => {
  it("opens and verifies screen territory_sales_manager_compliance", () => {
    cy.loginAsRole("territory_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/territory-sales-manager-compliance (TerritorySalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritorySalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagercompliance-screen").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-title").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritorySalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritorySalesManagerComplianceScreen successfully!\n");

  });
});
