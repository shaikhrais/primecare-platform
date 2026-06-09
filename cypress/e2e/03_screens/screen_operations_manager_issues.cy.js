// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_issues", () => {
  it("opens and verifies screen operations_manager_issues", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/issues (Operations Manager Issues)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/issues");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Issues...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerissues-screen").should("be.visible");
  cy.getCy("operationsmanagerissues-title").should("be.visible");
  cy.getCy("operationsmanagerissues-content").should("be.visible");
  cy.getCy("opsmanager-btn-refresh").should("be.visible");
  cy.getCy("opsmanager-btn-generate-report").should("be.visible");
  cy.getCy("opsmanager-btn-communicate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Issues...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_issues");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Issues successfully!\n");

  });
});
