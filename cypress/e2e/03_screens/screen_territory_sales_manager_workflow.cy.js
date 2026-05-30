// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_workflow", () => {
  it("opens and verifies screen territory_sales_manager_workflow", () => {
    cy.loginAsRole("territory_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/territory-sales-manager-workflow (TerritorySalesManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritorySalesManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-title").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritorySalesManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritorySalesManagerWorkflowScreen successfully!\n");

  });
});
