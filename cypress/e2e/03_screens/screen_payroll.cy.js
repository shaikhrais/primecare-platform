// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - payroll", () => {
  it("opens and verifies screen payroll", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/payroll (PayrollScreen)...");
  cy.visitWithSemantics("/executive/payroll");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PayrollScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("payroll-screen").should("be.visible");
  cy.getCy("payroll-title").should("be.visible");
  cy.getCy("payroll-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-financial-statements").should("be.visible");
  cy.getCy("cfo-dashboard-budget-vs-actual").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PayrollScreen...");
  cy.waitAndSee();
  cy.screenshot("payroll");
  
  cy.task("log", "✅ PROGRESS: - Verified PayrollScreen successfully!\n");

  });
});
