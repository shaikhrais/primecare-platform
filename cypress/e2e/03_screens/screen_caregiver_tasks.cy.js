// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_tasks", () => {
  it("opens and verifies screen caregiver_tasks", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/tasks (CaregiverTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CaregiverTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivertasks-screen").should("be.visible");
  cy.getCy("caregivertasks-title").should("be.visible");
  cy.getCy("caregivertasks-content").should("be.visible");
  cy.getCy("caregiver-btn-execute-compliance-scan").should("be.visible");
  cy.getCy("caregiver-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CaregiverTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_tasks");
  
  cy.task("log", "✅ PROGRESS: - Verified CaregiverTasksScreen successfully!\n");

  });
});
