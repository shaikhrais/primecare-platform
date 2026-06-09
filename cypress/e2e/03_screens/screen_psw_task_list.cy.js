// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_task_list", () => {
  it("opens and verifies screen psw_task_list", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Task List)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Task List...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasklist-screen").should("be.visible");
  cy.getCy("pswtasklist-title").should("be.visible");
  cy.getCy("pswtasklist-content").should("be.visible");
  cy.getCy("tasklist-btn-add").should("be.visible");
  cy.getCy("tasklist-btn-update").should("be.visible");
  cy.getCy("tasklist-btn-remove").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Task List...");
  cy.waitAndSee();
  cy.screenshot("psw_task_list");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Task List successfully!\n");

  });
});
