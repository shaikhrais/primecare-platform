// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_escalations", () => {
  it("opens and verifies screen customer_support_escalations", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Customer Support Escalations)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Customer Support Escalations...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportescalations-screen").should("be.visible");
  cy.getCy("customersupportescalations-title").should("be.visible");
  cy.getCy("customersupportescalations-content").should("be.visible");
  cy.getCy("customer-support-escalations-overview").should("be.visible");
  cy.getCy("customer-support-escalations-response").should("be.visible");
  cy.getCy("customer-support-escalations-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Customer Support Escalations...");
  cy.waitAndSee();
  cy.screenshot("customer_support_escalations");
  
  cy.task("log", "✅ PROGRESS: - Verified Customer Support Escalations successfully!\n");

  });
});
