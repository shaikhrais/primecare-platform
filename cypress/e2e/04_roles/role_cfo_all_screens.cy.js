// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cfo", () => {
  it("tests all screens for role cfo", () => {
    cy.loginAsRole("cfo");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Navigating to /offices/corporate/roles/cfo/dashboard (CfoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Checking shell & content for CfoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Saving screenshot for CfoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Verified CfoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Navigating to /executive/cfo-analytics (CfoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cfo-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Checking shell & content for CfoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoanalytics-screen").should("be.visible");
  cy.getCy("cfoanalytics-title").should("be.visible");
  cy.getCy("cfoanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Saving screenshot for CfoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_analytics");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Verified CfoAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Navigating to /executive/cfo-workflow (CfoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cfo-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Checking shell & content for CfoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoworkflow-screen").should("be.visible");
  cy.getCy("cfoworkflow-title").should("be.visible");
  cy.getCy("cfoworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Saving screenshot for CfoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Verified CfoWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Navigating to /offices/corporate/roles/cfo/revenue (CfoRevenueScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/revenue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Checking shell & content for CfoRevenueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforevenue-screen").should("be.visible");
  cy.getCy("cforevenue-title").should("be.visible");
  cy.getCy("cforevenue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Saving screenshot for CfoRevenueScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_revenue");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Verified CfoRevenueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Navigating to /offices/corporate/roles/cfo/expenses (CfoExpensesScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/expenses");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Checking shell & content for CfoExpensesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoexpenses-screen").should("be.visible");
  cy.getCy("cfoexpenses-title").should("be.visible");
  cy.getCy("cfoexpenses-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Saving screenshot for CfoExpensesScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_expenses");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Verified CfoExpensesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Navigating to /offices/corporate/roles/cfo/payroll (CfoPayrollScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/payroll");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Checking shell & content for CfoPayrollScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfopayroll-screen").should("be.visible");
  cy.getCy("cfopayroll-title").should("be.visible");
  cy.getCy("cfopayroll-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Saving screenshot for CfoPayrollScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_payroll");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Verified CfoPayrollScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Navigating to /offices/corporate/roles/cfo/invoices (CfoInvoicesScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/invoices");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Checking shell & content for CfoInvoicesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoinvoices-screen").should("be.visible");
  cy.getCy("cfoinvoices-title").should("be.visible");
  cy.getCy("cfoinvoices-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Saving screenshot for CfoInvoicesScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_invoices");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Verified CfoInvoicesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Navigating to /executive/cfo-tax (CfoTaxScreen)...");
  cy.visitWithSemantics("/executive/cfo-tax");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Checking shell & content for CfoTaxScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotax-screen").should("be.visible");
  cy.getCy("cfotax-title").should("be.visible");
  cy.getCy("cfotax-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Saving screenshot for CfoTaxScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_tax");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Verified CfoTaxScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Navigating to /offices/corporate/roles/cfo/profitability (CfoProfitabilityScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/profitability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Checking shell & content for CfoProfitabilityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoprofitability-screen").should("be.visible");
  cy.getCy("cfoprofitability-title").should("be.visible");
  cy.getCy("cfoprofitability-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Saving screenshot for CfoProfitabilityScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_profitability");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Verified CfoProfitabilityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Navigating to /executive/cfo-cashflow (CfoCashflowScreen)...");
  cy.visitWithSemantics("/executive/cfo-cashflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Checking shell & content for CfoCashflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocashflow-screen").should("be.visible");
  cy.getCy("cfocashflow-title").should("be.visible");
  cy.getCy("cfocashflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Saving screenshot for CfoCashflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_cashflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Verified CfoCashflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Navigating to /executive/financial-dashboard (FinancialDashboardScreen)...");
  cy.visitWithSemantics("/executive/financial-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Checking shell & content for FinancialDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Saving screenshot for FinancialDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Verified FinancialDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Navigating to /executive/revenue (RevenueScreen)...");
  cy.visitWithSemantics("/executive/revenue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Checking shell & content for RevenueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenue-screen").should("be.visible");
  cy.getCy("revenue-title").should("be.visible");
  cy.getCy("revenue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Saving screenshot for RevenueScreen...");
  cy.waitAndSee();
  cy.screenshot("revenue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Verified RevenueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Navigating to /executive/expense-management (ExpenseManagementScreen)...");
  cy.visitWithSemantics("/executive/expense-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Checking shell & content for ExpenseManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("expensemanagement-screen").should("be.visible");
  cy.getCy("expensemanagement-title").should("be.visible");
  cy.getCy("expensemanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Saving screenshot for ExpenseManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("expense_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Verified ExpenseManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Navigating to /executive/payroll (PayrollScreen)...");
  cy.visitWithSemantics("/executive/payroll");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Checking shell & content for PayrollScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("payroll-screen").should("be.visible");
  cy.getCy("payroll-title").should("be.visible");
  cy.getCy("payroll-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Saving screenshot for PayrollScreen...");
  cy.waitAndSee();
  cy.screenshot("payroll");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Verified PayrollScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Navigating to /executive/financial-operations4-k (FinancialOperations4KScreen)...");
  cy.visitWithSemantics("/executive/financial-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Checking shell & content for FinancialOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialoperations4k-screen").should("be.visible");
  cy.getCy("financialoperations4k-title").should("be.visible");
  cy.getCy("financialoperations4k-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Saving screenshot for FinancialOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Verified FinancialOperations4KScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Navigating to /offices/corporate/roles/cfo/accounts-payable (Cfo Accounts Payable)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/accounts-payable");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Checking shell & content for Cfo Accounts Payable...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfo accounts payable-screen").should("be.visible");
  cy.getCy("cfo accounts payable-title").should("be.visible");
  cy.getCy("cfo accounts payable-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Saving screenshot for Cfo Accounts Payable...");
  cy.waitAndSee();
  cy.screenshot("cfo_accounts_payable");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Verified Cfo Accounts Payable successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Navigating to /offices/corporate/roles/cfo/accounts-receivable (Cfo Accounts Receivable)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/accounts-receivable");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Checking shell & content for Cfo Accounts Receivable...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfo accounts receivable-screen").should("be.visible");
  cy.getCy("cfo accounts receivable-title").should("be.visible");
  cy.getCy("cfo accounts receivable-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Saving screenshot for Cfo Accounts Receivable...");
  cy.waitAndSee();
  cy.screenshot("cfo_accounts_receivable");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Verified Cfo Accounts Receivable successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Navigating to /offices/corporate/roles/cfo/financial-overview (Cfo Financial Overview)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/financial-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Checking shell & content for Cfo Financial Overview...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfo financial overview-screen").should("be.visible");
  cy.getCy("cfo financial overview-title").should("be.visible");
  cy.getCy("cfo financial overview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Saving screenshot for Cfo Financial Overview...");
  cy.waitAndSee();
  cy.screenshot("cfo_financial_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Verified Cfo Financial Overview successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Navigating to /offices/corporate/roles/cfo/franchise-financials (Cfo Franchise Financials)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/franchise-financials");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Checking shell & content for Cfo Franchise Financials...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfo franchise financials-screen").should("be.visible");
  cy.getCy("cfo franchise financials-title").should("be.visible");
  cy.getCy("cfo franchise financials-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Saving screenshot for Cfo Franchise Financials...");
  cy.waitAndSee();
  cy.screenshot("cfo_franchise_financials");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Verified Cfo Franchise Financials successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Navigating to /offices/corporate/roles/cfo/reports (Cfo Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Checking shell & content for Cfo Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfo reports-screen").should("be.visible");
  cy.getCy("cfo reports-title").should("be.visible");
  cy.getCy("cfo reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Saving screenshot for Cfo Reports...");
  cy.waitAndSee();
  cy.screenshot("cfo_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Verified Cfo Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Navigating to /offices/corporate/roles/cfo/tax-and-remittance (Cfo Tax And Remittance)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/tax-and-remittance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Checking shell & content for Cfo Tax And Remittance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfo tax and remittance-screen").should("be.visible");
  cy.getCy("cfo tax and remittance-title").should("be.visible");
  cy.getCy("cfo tax and remittance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Saving screenshot for Cfo Tax And Remittance...");
  cy.waitAndSee();
  cy.screenshot("cfo_tax_and_remittance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Verified Cfo Tax And Remittance successfully!\n");

  });
});
