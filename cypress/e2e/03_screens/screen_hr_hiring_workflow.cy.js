// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_workflow", () => {
  it("opens and verifies screen hr_hiring_workflow", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/hr-hiring-workflow (HrHiringWorkflowScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringworkflow-screen").should("be.visible");
  cy.getCy("hrhiringworkflow-title").should("be.visible");
  cy.getCy("hrhiringworkflow-content").should("be.visible");
  cy.getCy("ta-dashboard-btn-view-details").should("be.visible");
  cy.getCy("ta-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ta-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringWorkflowScreen successfully!\n");

  });
});
