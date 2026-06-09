// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_workflow", () => {
  it("opens and verifies screen cto_workflow", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cto-workflow (CtoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cto-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CtoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoworkflow-screen").should("be.visible");
  cy.getCy("ctoworkflow-title").should("be.visible");
  cy.getCy("ctoworkflow-content").should("be.visible");
  cy.getCy("ctoworkflow-btn-refresh").should("be.visible");
  cy.getCy("ctoworkflow-btn-view-reports").should("be.visible");
  cy.getCy("ctoworkflow-btn-add-technology").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CtoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CtoWorkflowScreen successfully!\n");

  });
});
