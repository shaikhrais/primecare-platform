// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_service_quality", () => {
  it("opens and verifies screen operations_manager_service_quality", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/service-quality (Operations Manager Service Quality)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/service-quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Service Quality...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerservicequality-screen").should("be.visible");
  cy.getCy("operationsmanagerservicequality-title").should("be.visible");
  cy.getCy("operationsmanagerservicequality-content").should("be.visible");
  cy.getCy("service-quality-metric-card").should("be.visible");
  cy.getCy("service-quality-trend-chart").should("be.visible");
  cy.getCy("customer-feedback-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Service Quality...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_service_quality");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Service Quality successfully!\n");

  });
});
