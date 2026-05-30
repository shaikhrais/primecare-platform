// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_command_center", () => {
  it("opens and verifies screen operations_command_center", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/operations-command-center (OperationsCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/operations-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OperationsCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationscommandcenter-screen").should("be.visible");
  cy.getCy("operationscommandcenter-title").should("be.visible");
  cy.getCy("operationscommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OperationsCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified OperationsCommandCenterScreen successfully!\n");

  });
});
