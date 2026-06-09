// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_payments", () => {
  it("opens and verifies screen client_payments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Client Payments)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client Payments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientpayments-screen").should("be.visible");
  cy.getCy("clientpayments-title").should("be.visible");
  cy.getCy("clientpayments-content").should("be.visible");
  cy.getCy("clientpayments-btn-review").should("be.visible");
  cy.getCy("clientpayments-btn-report").should("be.visible");
  cy.getCy("clientpayments-btn-manage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client Payments...");
  cy.waitAndSee();
  cy.screenshot("client_payments");
  
  cy.task("log", "✅ PROGRESS: - Verified Client Payments successfully!\n");

  });
});
