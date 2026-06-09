// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_branch_overview", () => {
  it("opens and verifies screen franchise_owner_branch_overview", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/franchise_owner/branch-overview (FranchiseOwnerBranchOverviewScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/branch-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOwnerBranchOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");
  cy.getCy("franchise-owner-btn-trigger-scan").should("be.visible");
  cy.getCy("franchise-owner-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOwnerBranchOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOwnerBranchOverviewScreen successfully!\n");

  });
});
