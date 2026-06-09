// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_command_center", () => {
  it("opens and verifies screen coo_command_center", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-command-center (CooCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/coo-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocommandcenter-screen").should("be.visible");
  cy.getCy("coocommandcenter-title").should("be.visible");
  cy.getCy("coocommandcenter-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh-metrics").should("be.visible");
  cy.getCy("coo-dashboard-view-audit").should("be.visible");
  cy.getCy("coo-dashboard-export-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified CooCommandCenterScreen successfully!\n");

  });
});
