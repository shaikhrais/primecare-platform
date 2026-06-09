// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_workflow", () => {
  it("opens and verifies screen rpn_workflow", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-workflow (RpnWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnworkflow-screen").should("be.visible");
  cy.getCy("rpnworkflow-title").should("be.visible");
  cy.getCy("rpnworkflow-content").should("be.visible");
  cy.getCy("rpn-dashboard-dressing-log").should("be.visible");
  cy.getCy("rpn-dashboard-immunization-summary").should("be.visible");
  cy.getCy("rpn-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnWorkflowScreen successfully!\n");

  });
});
