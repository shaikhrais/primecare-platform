// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_workflow", () => {
  it("opens and verifies screen franchise_workflow", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/franchise-workflow (FranchiseWorkflowScreen)...");
  cy.visitWithSemantics("/common/franchise-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");
  cy.getCy("franchise-dashboard-sales").should("be.visible");
  cy.getCy("franchise-dashboard-employees").should("be.visible");
  cy.getCy("franchise-dashboard-customers").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseWorkflowScreen successfully!\n");

  });
});
