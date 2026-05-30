// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_command_center", () => {
  it("opens and verifies screen psw_command_center", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/psw-command-center (PswCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified PswCommandCenterScreen successfully!\n");

  });
});
