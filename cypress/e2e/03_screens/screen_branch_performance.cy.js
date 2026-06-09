// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - branch_performance", () => {
  it("opens and verifies screen branch_performance", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/branch-performance (BranchPerformanceScreen)...");
  cy.visitWithSemantics("/executive/branch-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BranchPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("branchperformance-screen").should("be.visible");
  cy.getCy("branchperformance-title").should("be.visible");
  cy.getCy("branchperformance-content").should("be.visible");
  cy.getCy("dashboard-btn-refresh").should("be.visible");
  cy.getCy("dashboard-btn-report").should("be.visible");
  cy.getCy("dashboard-btn-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BranchPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("branch_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified BranchPerformanceScreen successfully!\n");

  });
});
