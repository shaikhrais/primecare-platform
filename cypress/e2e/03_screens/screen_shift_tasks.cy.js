// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shift_tasks", () => {
  it("opens and verifies screen shift_tasks", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/shift-tasks (ShiftTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ShiftTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ShiftTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("shift_tasks");
  
  cy.task("log", "✅ PROGRESS: - Verified ShiftTasksScreen successfully!\n");

  });
});
