// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_command_center4_k", () => {
  it("opens and verifies screen franchise_command_center4_k", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-command-center4-k (FranchiseCommandCenter4KScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseCommandCenter4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseCommandCenter4KScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseCommandCenter4KScreen successfully!\n");

  });
});
