// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_workflow", () => {
  it("opens and verifies screen ciso_workflow", () => {
    cy.loginAsRole("ciso");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/ciso-workflow (CisoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/ciso-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CisoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoworkflow-screen").should("be.visible");
  cy.getCy("cisoworkflow-title").should("be.visible");
  cy.getCy("cisoworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CisoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CisoWorkflowScreen successfully!\n");

  });
});
