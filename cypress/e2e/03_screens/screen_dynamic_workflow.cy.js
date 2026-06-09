// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_workflow", () => {
  it("opens and verifies screen dynamic_workflow", () => {
    cy.loginAsRole("dynamic");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/dynamic-workflow (DynamicScreenWorkflowScreen)...");
  cy.visitWithSemantics("/common/dynamic-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DynamicScreenWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicworkflow-screen").should("be.visible");
  cy.getCy("dynamicworkflow-title").should("be.visible");
  cy.getCy("dynamicworkflow-content").should("be.visible");
  cy.getCy("dynamic-workflow-btn-start").should("be.visible");
  cy.getCy("dynamic-workflow-btn-stop").should("be.visible");
  cy.getCy("dynamic-workflow-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DynamicScreenWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified DynamicScreenWorkflowScreen successfully!\n");

  });
});
