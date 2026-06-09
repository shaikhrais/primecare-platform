// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_workflow_performance", () => {
  it("opens and verifies screen coo_workflow_performance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/coo/workflow-performance (Coo Workflow Performance)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/workflow-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Workflow Performance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflowperformance-screen").should("be.visible");
  cy.getCy("cooworkflowperformance-title").should("be.visible");
  cy.getCy("cooworkflowperformance-content").should("be.visible");
  cy.getCy("workflow-performance-metrics").should("be.visible");
  cy.getCy("workflow-bottleneck-indicator").should("be.visible");
  cy.getCy("task-completion-stats").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Workflow Performance...");
  cy.waitAndSee();
  cy.screenshot("coo_workflow_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Workflow Performance successfully!\n");

  });
});
