// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_command_center", () => {
  it("opens and verifies screen franchise_command_center", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-command-center (FranchiseCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("franchise-dashboard-btn-request-training").should("be.visible");
  cy.getCy("franchise-dashboard-btn-send-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseCommandCenterScreen successfully!\n");

  });
});
