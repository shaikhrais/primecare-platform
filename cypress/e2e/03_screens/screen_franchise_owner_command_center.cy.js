// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_command_center", () => {
  it("opens and verifies screen franchise_owner_command_center", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-owner-command-center (FranchiseOwnerCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOwnerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOwnerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOwnerCommandCenterScreen successfully!\n");

  });
});
