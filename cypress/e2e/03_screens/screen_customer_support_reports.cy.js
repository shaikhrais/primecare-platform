// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_reports", () => {
  it("opens and verifies screen customer_support_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Customer Support Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Customer Support Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportreports-screen").should("be.visible");
  cy.getCy("customersupportreports-title").should("be.visible");
  cy.getCy("customersupportreports-content").should("be.visible");
  cy.getCy("customer-support-report-card").should("be.visible");
  cy.getCy("customer-support-trend-chart").should("be.visible");
  cy.getCy("alert-high-unresolved-issues").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Customer Support Reports...");
  cy.waitAndSee();
  cy.screenshot("customer_support_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Customer Support Reports successfully!\n");

  });
});
