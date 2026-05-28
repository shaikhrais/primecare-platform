// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cfo", () => {
  it("tests all screens for role cfo", () => {
    cy.loginAsRole("cfo");


  cy.visitWithSemantics("/executive/cfo-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");

  cy.visitWithSemantics("/executive/cfo-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoanalytics-screen").should("be.visible");
  cy.getCy("cfoanalytics-title").should("be.visible");
  cy.getCy("cfoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_analytics");

  cy.visitWithSemantics("/executive/cfo-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocompliance-screen").should("be.visible");
  cy.getCy("cfocompliance-title").should("be.visible");
  cy.getCy("cfocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_compliance");

  cy.visitWithSemantics("/executive/cfo-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoworkflow-screen").should("be.visible");
  cy.getCy("cfoworkflow-title").should("be.visible");
  cy.getCy("cfoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_workflow");

  cy.visitWithSemantics("/executive/cfo-revenue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforevenue-screen").should("be.visible");
  cy.getCy("cforevenue-title").should("be.visible");
  cy.getCy("cforevenue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_revenue");

  cy.visitWithSemantics("/executive/cfo-expenses");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoexpenses-screen").should("be.visible");
  cy.getCy("cfoexpenses-title").should("be.visible");
  cy.getCy("cfoexpenses-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_expenses");

  cy.visitWithSemantics("/executive/cfo-payroll");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfopayroll-screen").should("be.visible");
  cy.getCy("cfopayroll-title").should("be.visible");
  cy.getCy("cfopayroll-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_payroll");

  cy.visitWithSemantics("/executive/cfo-invoices");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoinvoices-screen").should("be.visible");
  cy.getCy("cfoinvoices-title").should("be.visible");
  cy.getCy("cfoinvoices-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_invoices");

  cy.visitWithSemantics("/executive/cfo-tax");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotax-screen").should("be.visible");
  cy.getCy("cfotax-title").should("be.visible");
  cy.getCy("cfotax-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_tax");

  cy.visitWithSemantics("/executive/cfo-profitability");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoprofitability-screen").should("be.visible");
  cy.getCy("cfoprofitability-title").should("be.visible");
  cy.getCy("cfoprofitability-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_profitability");

  cy.visitWithSemantics("/executive/cfo-cashflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocashflow-screen").should("be.visible");
  cy.getCy("cfocashflow-title").should("be.visible");
  cy.getCy("cfocashflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_cashflow");

  cy.visitWithSemantics("/executive/financial-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("financial_dashboard");

  cy.visitWithSemantics("/executive/revenue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenue-screen").should("be.visible");
  cy.getCy("revenue-title").should("be.visible");
  cy.getCy("revenue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue");

  cy.visitWithSemantics("/executive/expense-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("expensemanagement-screen").should("be.visible");
  cy.getCy("expensemanagement-title").should("be.visible");
  cy.getCy("expensemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("expense_management");

  cy.visitWithSemantics("/executive/payroll");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("payroll-screen").should("be.visible");
  cy.getCy("payroll-title").should("be.visible");
  cy.getCy("payroll-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("payroll");

  cy.visitWithSemantics("/executive/tax-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("taxcompliance-screen").should("be.visible");
  cy.getCy("taxcompliance-title").should("be.visible");
  cy.getCy("taxcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("tax_compliance");

  cy.visitWithSemantics("/executive/financial-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialoperations4k-screen").should("be.visible");
  cy.getCy("financialoperations4k-title").should("be.visible");
  cy.getCy("financialoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("financial_operations4_k");

  });
});
