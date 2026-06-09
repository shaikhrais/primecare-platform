// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - nursing_task", () => {
  it("opens and verifies screen nursing_task", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/nursing-task");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for NursingTaskScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nursingtask-screen").should("be.visible");
  cy.getCy("nursingtask-title").should("be.visible");
  cy.getCy("nursingtask-content").should("be.visible");
  cy.getCy("nursingtask-btn-administer-medication").should("be.visible");
  cy.getCy("nursingtask-btn-document-care").should("be.visible");
  cy.getCy("nursingtask-btn-report-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for NursingTaskScreen...");
  cy.waitAndSee();
  cy.screenshot("nursing_task");
  
  cy.task("log", "✅ PROGRESS: - Verified NursingTaskScreen successfully!\n");

  });
});
