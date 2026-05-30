// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_workflow", () => {
  it("opens and verifies screen franchise_sales_workflow", () => {
    cy.loginAsRole("franchise_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-sales-workflow (Franchise Sales Manager Compliance Workflow)...");
  cy.visitWithSemantics("/executive/franchise-sales-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager compliance workflow-screen").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-title").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Compliance Workflow successfully!\n");

  });
});
