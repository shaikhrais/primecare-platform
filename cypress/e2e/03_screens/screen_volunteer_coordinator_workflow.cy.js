// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_workflow", () => {
  it("opens and verifies screen volunteer_coordinator_workflow", () => {
    cy.loginAsRole("volunteer");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/volunteer-coordinator-workflow (VolunteerCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VolunteerCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorworkflow-screen").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-title").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-content").should("be.visible");
  cy.getCy("volunteer-dashboard-refresh").should("be.visible");
  cy.getCy("volunteer-task-execute").should("be.visible");
  cy.getCy("volunteer-sandbox-join").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VolunteerCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified VolunteerCoordinatorWorkflowScreen successfully!\n");

  });
});
