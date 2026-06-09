// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_templates", () => {
  it("opens and verifies screen customer_support_templates", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Customer Support Templates)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Customer Support Templates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupporttemplates-screen").should("be.visible");
  cy.getCy("customersupporttemplates-title").should("be.visible");
  cy.getCy("customersupporttemplates-content").should("be.visible");
  cy.getCy("customer-support-templates-list").should("be.visible");
  cy.getCy("customer-support-feedback-btn").should("be.visible");
  cy.getCy("customer-support-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Customer Support Templates...");
  cy.waitAndSee();
  cy.screenshot("customer_support_templates");
  
  cy.task("log", "✅ PROGRESS: - Verified Customer Support Templates successfully!\n");

  });
});
