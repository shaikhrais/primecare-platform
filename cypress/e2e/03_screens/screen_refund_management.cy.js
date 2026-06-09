// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - refund_management", () => {
  it("opens and verifies screen refund_management", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/refund-management (RefundManagementScreen)...");
  cy.visitWithSemantics("/staff/refund-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RefundManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("refundmanagement-screen").should("be.visible");
  cy.getCy("refundmanagement-title").should("be.visible");
  cy.getCy("refundmanagement-content").should("be.visible");
  cy.getCy("refundmanagement-btn-addtask").should("be.visible");
  cy.getCy("refundmanagement-btn-schedulemeeting").should("be.visible");
  cy.getCy("refundmanagement-btn-generatereport").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RefundManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("refund_management");
  
  cy.task("log", "✅ PROGRESS: - Verified RefundManagementScreen successfully!\n");

  });
});
