// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_tasks", () => {
  it("opens and verifies screen psw_tasks", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/visit-checklist (PswTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_tasks");
  
  cy.task("log", "✅ PROGRESS: - Verified PswTasksScreen successfully!\n");

  });
});
