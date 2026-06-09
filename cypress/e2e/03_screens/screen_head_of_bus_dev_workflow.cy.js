// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_bus_dev_workflow", () => {
  it("opens and verifies screen head_of_bus_dev_workflow", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/head-of-bus-dev-workflow (HeadOfBusDevWorkflowScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HeadOfBusDevWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevworkflow-screen").should("be.visible");
  cy.getCy("headofbusdevworkflow-title").should("be.visible");
  cy.getCy("headofbusdevworkflow-content").should("be.visible");
  cy.getCy("bd-dashboard-kpi-chart").should("be.visible");
  cy.getCy("bd-dashboard-pipeline-status").should("be.visible");
  cy.getCy("bd-dashboard-client-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HeadOfBusDevWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified HeadOfBusDevWorkflowScreen successfully!\n");

  });
});
