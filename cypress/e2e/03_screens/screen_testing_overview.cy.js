// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - testing_overview", () => {
  it("opens and verifies screen testing_overview", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/testing-overview (TestingOverviewScreen)...");
  cy.visitWithSemantics("/staff/testing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TestingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("testingoverview-screen").should("be.visible");
  cy.getCy("testingoverview-title").should("be.visible");
  cy.getCy("testingoverview-content").should("be.visible");
  cy.getCy("qa-dashboard-refresh-status").should("be.visible");
  cy.getCy("qa-dashboard-view-defects").should("be.visible");
  cy.getCy("qa-dashboard-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TestingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("testing_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified TestingOverviewScreen successfully!\n");

  });
});
