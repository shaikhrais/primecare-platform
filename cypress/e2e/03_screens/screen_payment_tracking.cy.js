// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - payment_tracking", () => {
  it("opens and verifies screen payment_tracking", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/payment-tracking (PaymentTrackingScreen)...");
  cy.visitWithSemantics("/staff/payment-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PaymentTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("paymenttracking-screen").should("be.visible");
  cy.getCy("paymenttracking-title").should("be.visible");
  cy.getCy("paymenttracking-content").should("be.visible");
  cy.getCy("paymenttracking-btn-addtask").should("be.visible");
  cy.getCy("paymenttracking-btn-schedulemeeting").should("be.visible");
  cy.getCy("paymenttracking-btn-sendcommunication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PaymentTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("payment_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified PaymentTrackingScreen successfully!\n");

  });
});
