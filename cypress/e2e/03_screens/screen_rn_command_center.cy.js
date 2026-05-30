// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_command_center", () => {
  it("opens and verifies screen rn_command_center", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-command-center (RnCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncommandcenter-screen").should("be.visible");
  cy.getCy("rncommandcenter-title").should("be.visible");
  cy.getCy("rncommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified RnCommandCenterScreen successfully!\n");

  });
});
