// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_command_center", () => {
  it("opens and verifies screen rmt_command_center", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/command-center (RmtCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcommandcenter-screen").should("be.visible");
  cy.getCy("rmtcommandcenter-title").should("be.visible");
  cy.getCy("rmtcommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtCommandCenterScreen successfully!\n");

  });
});
