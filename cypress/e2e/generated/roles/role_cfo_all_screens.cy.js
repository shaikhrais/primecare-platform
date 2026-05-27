// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.cfo@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - cfo", () => {
  it("tests all screens for role cfo", () => {
    login();


  cy.visit("/executive/cfo-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfodashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfodashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cfodashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_dashboard");

  cy.visit("/executive/cfo-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfoanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfoanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cfoanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_analytics");

  cy.visit("/executive/cfo-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfocompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfocompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cfocompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_compliance");

  cy.visit("/executive/cfo-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfoworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfoworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cfoworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_workflow");

  cy.visit("/executive/cfo-revenue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cforevenue-screen"]`).should("be.visible");
  cy.get(`[data-cy="cforevenue-title"]`).should("be.visible");
  cy.get(`[data-cy="cforevenue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_revenue");

  cy.visit("/executive/cfo-expenses");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfoexpenses-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfoexpenses-title"]`).should("be.visible");
  cy.get(`[data-cy="cfoexpenses-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_expenses");

  cy.visit("/executive/cfo-payroll");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfopayroll-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfopayroll-title"]`).should("be.visible");
  cy.get(`[data-cy="cfopayroll-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_payroll");

  cy.visit("/executive/cfo-invoices");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfoinvoices-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfoinvoices-title"]`).should("be.visible");
  cy.get(`[data-cy="cfoinvoices-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_invoices");

  cy.visit("/executive/cfo-tax");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfotax-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfotax-title"]`).should("be.visible");
  cy.get(`[data-cy="cfotax-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_tax");

  cy.visit("/executive/cfo-profitability");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfoprofitability-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfoprofitability-title"]`).should("be.visible");
  cy.get(`[data-cy="cfoprofitability-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_profitability");

  cy.visit("/executive/cfo-cashflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cfocashflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cfocashflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cfocashflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cfo_cashflow");

  cy.visit("/executive/financial-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financialdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="financialdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="financialdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("financial_dashboard");

  cy.visit("/executive/revenue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="revenue-screen"]`).should("be.visible");
  cy.get(`[data-cy="revenue-title"]`).should("be.visible");
  cy.get(`[data-cy="revenue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("revenue");

  cy.visit("/executive/expense-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="expensemanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="expensemanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="expensemanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("expense_management");

  cy.visit("/executive/payroll");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="payroll-screen"]`).should("be.visible");
  cy.get(`[data-cy="payroll-title"]`).should("be.visible");
  cy.get(`[data-cy="payroll-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("payroll");

  cy.visit("/executive/tax-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="taxcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="taxcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="taxcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("tax_compliance");

  cy.visit("/executive/financial-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financialoperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="financialoperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="financialoperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("financial_operations4_k");

  });
});
