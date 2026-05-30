// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staffing_overview", () => {
  it("opens and verifies screen staffing_overview", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/staffing-overview (StaffingOverviewScreen)...");
  cy.visitWithSemantics("/executive/staffing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for StaffingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffingoverview-screen").should("be.visible");
  cy.getCy("staffingoverview-title").should("be.visible");
  cy.getCy("staffingoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for StaffingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("staffing_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified StaffingOverviewScreen successfully!\n");

  });
});
