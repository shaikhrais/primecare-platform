// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_overview", () => {
  it("opens and verifies screen franchise_overview", () => {
    cy.loginAsRole("ceo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-overview (FranchiseOverviewScreen)...");
  cy.visitWithSemantics("/executive/franchise-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseoverview-screen").should("be.visible");
  cy.getCy("franchiseoverview-title").should("be.visible");
  cy.getCy("franchiseoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOverviewScreen successfully!\n");

  });
});
