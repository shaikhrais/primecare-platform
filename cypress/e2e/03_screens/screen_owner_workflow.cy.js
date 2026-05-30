// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_workflow", () => {
  it("opens and verifies screen owner_workflow", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/owner-workflow (OwnerWorkflowScreen)...");
  cy.visitWithSemantics("/executive/owner-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OwnerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OwnerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified OwnerWorkflowScreen successfully!\n");

  });
});
