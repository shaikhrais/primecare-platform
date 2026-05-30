// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_workflow", () => {
  it("opens and verifies screen portal_workflow", () => {
    cy.loginAsRole("portal");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/portal-workflow (PortalWorkflowScreen)...");
  cy.visitWithSemantics("/common/portal-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PortalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalworkflow-screen").should("be.visible");
  cy.getCy("portalworkflow-title").should("be.visible");
  cy.getCy("portalworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PortalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified PortalWorkflowScreen successfully!\n");

  });
});
