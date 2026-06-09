// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_workflow", () => {
  it("opens and verifies screen hr_director_workflow", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/hr-director-workflow (HrDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/hr-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-reports").should("be.visible");
  cy.getCy("hrdashboard-btn-manage-policies").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified HrDirectorWorkflowScreen successfully!\n");

  });
});
