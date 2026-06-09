// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_workflow", () => {
  it("opens and verifies screen scrum_master_workflow", () => {
    cy.loginAsRole("scrum_master");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/scrum-master-workflow (ScrumMasterWorkflowScreen)...");
  cy.visitWithSemantics("/management/scrum-master-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ScrumMasterWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterworkflow-screen").should("be.visible");
  cy.getCy("scrummasterworkflow-title").should("be.visible");
  cy.getCy("scrummasterworkflow-content").should("be.visible");
  cy.getCy("scrum-dashboard-btn-add-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-resolve-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-start-retrospective").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ScrumMasterWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ScrumMasterWorkflowScreen successfully!\n");

  });
});
