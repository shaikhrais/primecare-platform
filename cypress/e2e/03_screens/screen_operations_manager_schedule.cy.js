// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_schedule", () => {
  it("opens and verifies screen operations_manager_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/schedule (Operations Manager Schedule)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerschedule-screen").should("be.visible");
  cy.getCy("operationsmanagerschedule-title").should("be.visible");
  cy.getCy("operationsmanagerschedule-content").should("be.visible");
  cy.getCy("operations-schedule-overview").should("be.visible");
  cy.getCy("operations-btn-approve").should("be.visible");
  cy.getCy("operations-btn-reject").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Schedule...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Schedule successfully!\n");

  });
});
