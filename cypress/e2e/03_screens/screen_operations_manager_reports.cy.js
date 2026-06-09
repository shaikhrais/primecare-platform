// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_reports", () => {
  it("opens and verifies screen operations_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/reports (Operations Manager Reports)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerreports-screen").should("be.visible");
  cy.getCy("operationsmanagerreports-title").should("be.visible");
  cy.getCy("operationsmanagerreports-content").should("be.visible");
  cy.getCy("operationsmanager-btn-generate-report").should("be.visible");
  cy.getCy("operationsmanager-btn-send-feedback").should("be.visible");
  cy.getCy("operationsmanager-btn-view-historical").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Reports successfully!\n");

  });
});
