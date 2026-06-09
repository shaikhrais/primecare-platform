// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_workflow", () => {
  it("opens and verifies screen rn_workflow", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-workflow (RnWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnworkflow-screen").should("be.visible");
  cy.getCy("rnworkflow-title").should("be.visible");
  cy.getCy("rnworkflow-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-list").should("be.visible");
  cy.getCy("rn-dashboard-medication-records").should("be.visible");
  cy.getCy("rn-dashboard-care-plan-editor").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified RnWorkflowScreen successfully!\n");

  });
});
