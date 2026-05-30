// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_tasks", () => {
  it("opens and verifies screen rn_tasks", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-tasks (RnTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rntasks-screen").should("be.visible");
  cy.getCy("rntasks-title").should("be.visible");
  cy.getCy("rntasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_tasks");
  
  cy.task("log", "✅ PROGRESS: - Verified RnTasksScreen successfully!\n");

  });
});
