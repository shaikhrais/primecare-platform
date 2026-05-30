// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_operations_overview", () => {
  it("opens and verifies screen coo_operations_overview", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-operations-overview (CooOperationsOverviewScreen)...");
  cy.visitWithSemantics("/executive/coo-operations-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooOperationsOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coooperationsoverview-screen").should("be.visible");
  cy.getCy("coooperationsoverview-title").should("be.visible");
  cy.getCy("coooperationsoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooOperationsOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_operations_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified CooOperationsOverviewScreen successfully!\n");

  });
});
