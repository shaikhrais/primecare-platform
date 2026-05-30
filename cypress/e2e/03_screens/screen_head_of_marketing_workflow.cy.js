// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_workflow", () => {
  it("opens and verifies screen head_of_marketing_workflow", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/head-of-marketing-workflow (HeadOfMarketingWorkflowScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HeadOfMarketingWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingworkflow-screen").should("be.visible");
  cy.getCy("headofmarketingworkflow-title").should("be.visible");
  cy.getCy("headofmarketingworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HeadOfMarketingWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified HeadOfMarketingWorkflowScreen successfully!\n");

  });
});
