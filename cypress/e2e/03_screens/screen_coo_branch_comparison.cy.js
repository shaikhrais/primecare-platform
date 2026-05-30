// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_branch_comparison", () => {
  it("opens and verifies screen coo_branch_comparison", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-branch-comparison (CooBranchComparisonScreen)...");
  cy.visitWithSemantics("/executive/coo-branch-comparison");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooBranchComparisonScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coobranchcomparison-screen").should("be.visible");
  cy.getCy("coobranchcomparison-title").should("be.visible");
  cy.getCy("coobranchcomparison-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooBranchComparisonScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_branch_comparison");
  
  cy.task("log", "✅ PROGRESS: - Verified CooBranchComparisonScreen successfully!\n");

  });
});
