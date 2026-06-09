// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_daily_operations", () => {
  it("opens and verifies screen operations_manager_daily_operations", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/daily-operations (Operations Manager Daily Operations)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/daily-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Daily Operations...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdailyoperations-screen").should("be.visible");
  cy.getCy("operationsmanagerdailyoperations-title").should("be.visible");
  cy.getCy("operationsmanagerdailyoperations-content").should("be.visible");
  cy.getCy("operations-dashboard-performance").should("be.visible");
  cy.getCy("operations-dashboard-issues-alert").should("be.visible");
  cy.getCy("operations-dashboard-team-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Daily Operations...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_daily_operations");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Daily Operations successfully!\n");

  });
});
