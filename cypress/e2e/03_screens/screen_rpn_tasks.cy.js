// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_tasks", () => {
  it("opens and verifies screen rpn_tasks", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpntasks-screen").should("be.visible");
  cy.getCy("rpntasks-title").should("be.visible");
  cy.getCy("rpntasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_tasks");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnTasksScreen successfully!\n");

  });
});
