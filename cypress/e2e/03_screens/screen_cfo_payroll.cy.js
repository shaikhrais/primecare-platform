// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_payroll", () => {
  it("opens and verifies screen cfo_payroll", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-payroll (CfoPayrollScreen)...");
  cy.visitWithSemantics("/executive/cfo-payroll");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoPayrollScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfopayroll-screen").should("be.visible");
  cy.getCy("cfopayroll-title").should("be.visible");
  cy.getCy("cfopayroll-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoPayrollScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_payroll");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoPayrollScreen successfully!\n");

  });
});
