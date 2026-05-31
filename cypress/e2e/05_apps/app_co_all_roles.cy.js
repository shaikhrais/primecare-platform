// AUTO-GENERATED APP E2E SPEC. SYSTEMATICALLY GENERATED.
// Tests all allowed roles and their respective screens on the portal.
// Leverages reusable SSO commands and custom Semantics selector lookups.

describe("App All Roles All Screens - Primecare Corporate", () => {

  it("verifies operation flow for role: CTO", () => {
    cy.loginAsRole("cto");

    // [1/7] - Screen: ApiMonitoringScreen (api_monitoring)
    cy.task("log", "PROGRESS: Visiting /executive/api-monitoring (ApiMonitoringScreen)...");
    cy.visitWithSemantics("/executive/api-monitoring");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("apimonitoring-screen").should("be.visible");
    cy.getCy("apimonitoring-title").should("be.visible");
    cy.getCy("apimonitoring-content").should("be.visible");
    cy.screenshot("co_cto_api_monitoring");

    // [2/7] - Screen: ArchitecturePlanningDashboardScreen (architecture_planning_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/architecture-planning-dashboard (ArchitecturePlanningDashboardScreen)...");
    cy.visitWithSemantics("/common/architecture-planning-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("architectureplanningdashboard-screen").should("be.visible");
    cy.getCy("architectureplanningdashboard-title").should("be.visible");
    cy.getCy("architectureplanningdashboard-content").should("be.visible");
    cy.screenshot("co_cto_architecture_planning_dashboard");

    // [3/7] - Screen: CtoDashboardScreen (cto_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/cto-dashboard (CtoDashboardScreen)...");
    cy.visitWithSemantics("/executive/cto-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("ctodashboard-screen").should("be.visible");
    cy.getCy("ctodashboard-title").should("be.visible");
    cy.getCy("ctodashboard-content").should("be.visible");
    cy.screenshot("co_cto_cto_dashboard");

    // [4/7] - Screen: DeploymentCenterScreen (deployment_center)
    cy.task("log", "PROGRESS: Visiting /executive/deployment-center (DeploymentCenterScreen)...");
    cy.visitWithSemantics("/executive/deployment-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("deploymentcenter-screen").should("be.visible");
    cy.getCy("deploymentcenter-title").should("be.visible");
    cy.getCy("deploymentcenter-content").should("be.visible");
    cy.screenshot("co_cto_deployment_center");

    // [5/7] - Screen: ReleaseManagementScreen (release_management)
    cy.task("log", "PROGRESS: Visiting /executive/release-management (ReleaseManagementScreen)...");
    cy.visitWithSemantics("/executive/release-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("releasemanagement-screen").should("be.visible");
    cy.getCy("releasemanagement-title").should("be.visible");
    cy.getCy("releasemanagement-content").should("be.visible");
    cy.screenshot("co_cto_release_management");

    // [6/7] - Screen: SecurityAuditScreen (security_audit)
    cy.task("log", "PROGRESS: Visiting /executive/security-audit (SecurityAuditScreen)...");
    cy.visitWithSemantics("/executive/security-audit");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("securityaudit-screen").should("be.visible");
    cy.getCy("securityaudit-title").should("be.visible");
    cy.getCy("securityaudit-content").should("be.visible");
    cy.screenshot("co_cto_security_audit");

    // [7/7] - Screen: SystemHealthScreen (system_health)
    cy.task("log", "PROGRESS: Visiting /executive/system-health (SystemHealthScreen)...");
    cy.visitWithSemantics("/executive/system-health");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("systemhealth-screen").should("be.visible");
    cy.getCy("systemhealth-title").should("be.visible");
    cy.getCy("systemhealth-content").should("be.visible");
    cy.screenshot("co_cto_system_health");
  });

  it("verifies operation flow for role: COO", () => {
    cy.loginAsRole("coo");

    // [1/12] - Screen: BranchPerformanceScreen (branch_performance)
    cy.task("log", "PROGRESS: Visiting /executive/branch-performance (BranchPerformanceScreen)...");
    cy.visitWithSemantics("/executive/branch-performance");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("branchperformance-screen").should("be.visible");
    cy.getCy("branchperformance-title").should("be.visible");
    cy.getCy("branchperformance-content").should("be.visible");
    cy.screenshot("co_coo_branch_performance");

    // [2/12] - Screen: CooBranchComparisonScreen (coo_branch_comparison)
    cy.task("log", "PROGRESS: Visiting /executive/coo-branch-comparison (CooBranchComparisonScreen)...");
    cy.visitWithSemantics("/executive/coo-branch-comparison");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("coobranchcomparison-screen").should("be.visible");
    cy.getCy("coobranchcomparison-title").should("be.visible");
    cy.getCy("coobranchcomparison-content").should("be.visible");
    cy.screenshot("co_coo_coo_branch_comparison");

    // [3/12] - Screen: CooCommandCenterScreen (coo_command_center)
    cy.task("log", "PROGRESS: Visiting /executive/coo-command-center (CooCommandCenterScreen)...");
    cy.visitWithSemantics("/executive/coo-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("coocommandcenter-screen").should("be.visible");
    cy.getCy("coocommandcenter-title").should("be.visible");
    cy.getCy("coocommandcenter-content").should("be.visible");
    cy.screenshot("co_coo_coo_command_center");

    // [4/12] - Screen: CooDashboardScreen (coo_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/coo-dashboard (CooDashboardScreen)...");
    cy.visitWithSemantics("/executive/coo-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("coodashboard-screen").should("be.visible");
    cy.getCy("coodashboard-title").should("be.visible");
    cy.getCy("coodashboard-content").should("be.visible");
    cy.screenshot("co_coo_coo_dashboard");

    // [5/12] - Screen: CooOperationsOverviewScreen (coo_operations_overview)
    cy.task("log", "PROGRESS: Visiting /executive/coo-operations-overview (CooOperationsOverviewScreen)...");
    cy.visitWithSemantics("/executive/coo-operations-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("coooperationsoverview-screen").should("be.visible");
    cy.getCy("coooperationsoverview-title").should("be.visible");
    cy.getCy("coooperationsoverview-content").should("be.visible");
    cy.screenshot("co_coo_coo_operations_overview");

    // [6/12] - Screen: CooSchedulingHealthScreen (coo_scheduling_health)
    cy.task("log", "PROGRESS: Visiting /executive/coo-scheduling-health (CooSchedulingHealthScreen)...");
    cy.visitWithSemantics("/executive/coo-scheduling-health");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cooschedulinghealth-screen").should("be.visible");
    cy.getCy("cooschedulinghealth-title").should("be.visible");
    cy.getCy("cooschedulinghealth-content").should("be.visible");
    cy.screenshot("co_coo_coo_scheduling_health");

    // [7/12] - Screen: CooStaffingScreen (coo_staffing)
    cy.task("log", "PROGRESS: Visiting /executive/coo-staffing (CooStaffingScreen)...");
    cy.visitWithSemantics("/executive/coo-staffing");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("coostaffing-screen").should("be.visible");
    cy.getCy("coostaffing-title").should("be.visible");
    cy.getCy("coostaffing-content").should("be.visible");
    cy.screenshot("co_coo_coo_staffing");

    // [8/12] - Screen: CooWorkflowIssuesScreen (coo_workflow_issues)
    cy.task("log", "PROGRESS: Visiting /executive/coo-workflow-issues (CooWorkflowIssuesScreen)...");
    cy.visitWithSemantics("/executive/coo-workflow-issues");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cooworkflowissues-screen").should("be.visible");
    cy.getCy("cooworkflowissues-title").should("be.visible");
    cy.getCy("cooworkflowissues-content").should("be.visible");
    cy.screenshot("co_coo_coo_workflow_issues");

    // [9/12] - Screen: OperationsCommandCenterScreen (operations_command_center)
    cy.task("log", "PROGRESS: Visiting /executive/operations-command-center (OperationsCommandCenterScreen)...");
    cy.visitWithSemantics("/executive/operations-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("operationscommandcenter-screen").should("be.visible");
    cy.getCy("operationscommandcenter-title").should("be.visible");
    cy.getCy("operationscommandcenter-content").should("be.visible");
    cy.screenshot("co_coo_operations_command_center");

    // [10/12] - Screen: ServiceQualityScreen (service_quality)
    cy.task("log", "PROGRESS: Visiting /executive/service-quality (ServiceQualityScreen)...");
    cy.visitWithSemantics("/executive/service-quality");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("servicequality-screen").should("be.visible");
    cy.getCy("servicequality-title").should("be.visible");
    cy.getCy("servicequality-content").should("be.visible");
    cy.screenshot("co_coo_service_quality");

    // [11/12] - Screen: StaffingOverviewScreen (staffing_overview)
    cy.task("log", "PROGRESS: Visiting /executive/staffing-overview (StaffingOverviewScreen)...");
    cy.visitWithSemantics("/executive/staffing-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("staffingoverview-screen").should("be.visible");
    cy.getCy("staffingoverview-title").should("be.visible");
    cy.getCy("staffingoverview-content").should("be.visible");
    cy.screenshot("co_coo_staffing_overview");

    // [12/12] - Screen: WorkflowIssueScreen (workflow_issue)
    cy.task("log", "PROGRESS: Visiting /executive/workflow-issue (WorkflowIssueScreen)...");
    cy.visitWithSemantics("/executive/workflow-issue");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("workflowissue-screen").should("be.visible");
    cy.getCy("workflowissue-title").should("be.visible");
    cy.getCy("workflowissue-content").should("be.visible");
    cy.screenshot("co_coo_workflow_issue");
  });

  it("verifies operation flow for role: CFO", () => {
    cy.loginAsRole("cfo");

    // [1/14] - Screen: CfoCashflowScreen (cfo_cashflow)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-cashflow (CfoCashflowScreen)...");
    cy.visitWithSemantics("/executive/cfo-cashflow");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfocashflow-screen").should("be.visible");
    cy.getCy("cfocashflow-title").should("be.visible");
    cy.getCy("cfocashflow-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_cashflow");

    // [2/14] - Screen: CfoDashboardScreen (cfo_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-dashboard (CfoDashboardScreen)...");
    cy.visitWithSemantics("/executive/cfo-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfodashboard-screen").should("be.visible");
    cy.getCy("cfodashboard-title").should("be.visible");
    cy.getCy("cfodashboard-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_dashboard");

    // [3/14] - Screen: CfoExpensesScreen (cfo_expenses)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-expenses (CfoExpensesScreen)...");
    cy.visitWithSemantics("/executive/cfo-expenses");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfoexpenses-screen").should("be.visible");
    cy.getCy("cfoexpenses-title").should("be.visible");
    cy.getCy("cfoexpenses-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_expenses");

    // [4/14] - Screen: CfoInvoicesScreen (cfo_invoices)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-invoices (CfoInvoicesScreen)...");
    cy.visitWithSemantics("/executive/cfo-invoices");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfoinvoices-screen").should("be.visible");
    cy.getCy("cfoinvoices-title").should("be.visible");
    cy.getCy("cfoinvoices-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_invoices");

    // [5/14] - Screen: CfoPayrollScreen (cfo_payroll)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-payroll (CfoPayrollScreen)...");
    cy.visitWithSemantics("/executive/cfo-payroll");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfopayroll-screen").should("be.visible");
    cy.getCy("cfopayroll-title").should("be.visible");
    cy.getCy("cfopayroll-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_payroll");

    // [6/14] - Screen: CfoProfitabilityScreen (cfo_profitability)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-profitability (CfoProfitabilityScreen)...");
    cy.visitWithSemantics("/executive/cfo-profitability");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfoprofitability-screen").should("be.visible");
    cy.getCy("cfoprofitability-title").should("be.visible");
    cy.getCy("cfoprofitability-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_profitability");

    // [7/14] - Screen: CfoRevenueScreen (cfo_revenue)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-revenue (CfoRevenueScreen)...");
    cy.visitWithSemantics("/executive/cfo-revenue");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cforevenue-screen").should("be.visible");
    cy.getCy("cforevenue-title").should("be.visible");
    cy.getCy("cforevenue-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_revenue");

    // [8/14] - Screen: CfoTaxScreen (cfo_tax)
    cy.task("log", "PROGRESS: Visiting /executive/cfo-tax (CfoTaxScreen)...");
    cy.visitWithSemantics("/executive/cfo-tax");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cfotax-screen").should("be.visible");
    cy.getCy("cfotax-title").should("be.visible");
    cy.getCy("cfotax-content").should("be.visible");
    cy.screenshot("co_cfo_cfo_tax");

    // [9/14] - Screen: ExpenseManagementScreen (expense_management)
    cy.task("log", "PROGRESS: Visiting /executive/expense-management (ExpenseManagementScreen)...");
    cy.visitWithSemantics("/executive/expense-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("expensemanagement-screen").should("be.visible");
    cy.getCy("expensemanagement-title").should("be.visible");
    cy.getCy("expensemanagement-content").should("be.visible");
    cy.screenshot("co_cfo_expense_management");

    // [10/14] - Screen: FinancialDashboardScreen (financial_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/financial-dashboard (FinancialDashboardScreen)...");
    cy.visitWithSemantics("/executive/financial-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("financialdashboard-screen").should("be.visible");
    cy.getCy("financialdashboard-title").should("be.visible");
    cy.getCy("financialdashboard-content").should("be.visible");
    cy.screenshot("co_cfo_financial_dashboard");

    // [11/14] - Screen: FinancialOperations4KScreen (financial_operations4_k)
    cy.task("log", "PROGRESS: Visiting /executive/financial-operations4-k (FinancialOperations4KScreen)...");
    cy.visitWithSemantics("/executive/financial-operations4-k");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("financialoperations4k-screen").should("be.visible");
    cy.getCy("financialoperations4k-title").should("be.visible");
    cy.getCy("financialoperations4k-content").should("be.visible");
    cy.screenshot("co_cfo_financial_operations4_k");

    // [12/14] - Screen: PayrollScreen (payroll)
    cy.task("log", "PROGRESS: Visiting /executive/payroll (PayrollScreen)...");
    cy.visitWithSemantics("/executive/payroll");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("payroll-screen").should("be.visible");
    cy.getCy("payroll-title").should("be.visible");
    cy.getCy("payroll-content").should("be.visible");
    cy.screenshot("co_cfo_payroll");

    // [13/14] - Screen: RevenueScreen (revenue)
    cy.task("log", "PROGRESS: Visiting /executive/revenue (RevenueScreen)...");
    cy.visitWithSemantics("/executive/revenue");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("revenue-screen").should("be.visible");
    cy.getCy("revenue-title").should("be.visible");
    cy.getCy("revenue-content").should("be.visible");
    cy.screenshot("co_cfo_revenue");

    // [14/14] - Screen: TaxComplianceScreen (tax_compliance)
    cy.task("log", "PROGRESS: Visiting /executive/tax-compliance (TaxComplianceScreen)...");
    cy.visitWithSemantics("/executive/tax-compliance");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("taxcompliance-screen").should("be.visible");
    cy.getCy("taxcompliance-title").should("be.visible");
    cy.getCy("taxcompliance-content").should("be.visible");
    cy.screenshot("co_cfo_tax_compliance");
  });

  it("verifies operation flow for role: CISO", () => {
    cy.loginAsRole("ciso");

    // [1/1] - Screen: CisoDashboardScreen (ciso_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/ciso-dashboard (CisoDashboardScreen)...");
    cy.visitWithSemantics("/executive/ciso-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("cisodashboard-screen").should("be.visible");
    cy.getCy("cisodashboard-title").should("be.visible");
    cy.getCy("cisodashboard-content").should("be.visible");
    cy.screenshot("co_ciso_ciso_dashboard");
  });

  it("verifies operation flow for role: CEO", () => {
    cy.loginAsRole("ceo");

    // [1/6] - Screen: EnterpriseCommandCenter4KScreen (enterprise_command_center4_k)
    cy.task("log", "PROGRESS: Visiting /executive/enterprise-command-center4-k (EnterpriseCommandCenter4KScreen)...");
    cy.visitWithSemantics("/executive/enterprise-command-center4-k");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("enterprisecommandcenter4k-screen").should("be.visible");
    cy.getCy("enterprisecommandcenter4k-title").should("be.visible");
    cy.getCy("enterprisecommandcenter4k-content").should("be.visible");
    cy.screenshot("co_ceo_enterprise_command_center4_k");

    // [2/6] - Screen: EnterpriseHealthScreen (enterprise_health)
    cy.task("log", "PROGRESS: Visiting /executive/enterprise-health (EnterpriseHealthScreen)...");
    cy.visitWithSemantics("/executive/enterprise-health");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("enterprisehealth-screen").should("be.visible");
    cy.getCy("enterprisehealth-title").should("be.visible");
    cy.getCy("enterprisehealth-content").should("be.visible");
    cy.screenshot("co_ceo_enterprise_health");

    // [3/6] - Screen: ExecutiveCommandCenterScreen (executive_command_center)
    cy.task("log", "PROGRESS: Visiting /executive/executive-command-center (ExecutiveCommandCenterScreen)...");
    cy.visitWithSemantics("/executive/executive-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("executivecommandcenter-screen").should("be.visible");
    cy.getCy("executivecommandcenter-title").should("be.visible");
    cy.getCy("executivecommandcenter-content").should("be.visible");
    cy.screenshot("co_ceo_executive_command_center");

    // [4/6] - Screen: FranchiseOverviewScreen (franchise_overview)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-overview (FranchiseOverviewScreen)...");
    cy.visitWithSemantics("/executive/franchise-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseoverview-screen").should("be.visible");
    cy.getCy("franchiseoverview-title").should("be.visible");
    cy.getCy("franchiseoverview-content").should("be.visible");
    cy.screenshot("co_ceo_franchise_overview");

    // [5/6] - Screen: RevenueAnalyticsScreen (revenue_analytics)
    cy.task("log", "PROGRESS: Visiting /executive/revenue-analytics (RevenueAnalyticsScreen)...");
    cy.visitWithSemantics("/executive/revenue-analytics");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("revenueanalytics-screen").should("be.visible");
    cy.getCy("revenueanalytics-title").should("be.visible");
    cy.getCy("revenueanalytics-content").should("be.visible");
    cy.screenshot("co_ceo_revenue_analytics");

    // [6/6] - Screen: RiskManagementScreen (risk_management)
    cy.task("log", "PROGRESS: Visiting /executive/risk-management (RiskManagementScreen)...");
    cy.visitWithSemantics("/executive/risk-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("riskmanagement-screen").should("be.visible");
    cy.getCy("riskmanagement-title").should("be.visible");
    cy.getCy("riskmanagement-content").should("be.visible");
    cy.screenshot("co_ceo_risk_management");
  });

  it("verifies operation flow for role: FINANCE_DIRECTOR", () => {
    cy.loginAsRole("finance_director");

    // [1/1] - Screen: FinanceDirectorDashboardScreen (finance_director_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/finance-director-dashboard (FinanceDirectorDashboardScreen)...");
    cy.visitWithSemantics("/executive/finance-director-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("financedirectordashboard-screen").should("be.visible");
    cy.getCy("financedirectordashboard-title").should("be.visible");
    cy.getCy("financedirectordashboard-content").should("be.visible");
    cy.screenshot("co_finance_director_finance_director_dashboard");
  });

  it("verifies operation flow for role: HR_DIRECTOR", () => {
    cy.loginAsRole("hr_director");

    // [1/7] - Screen: HrDirectorCredentialExpiryScreen (hr_director_credential_expiry)
    cy.task("log", "PROGRESS: Visiting /executive/hr-director-credential-expiry (HrDirectorCredentialExpiryScreen)...");
    cy.visitWithSemantics("/executive/hr-director-credential-expiry");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
    cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
    cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_director_credential_expiry");

    // [2/7] - Screen: HrDirectorDashboardScreen (hr_director_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/hr-director-dashboard (HrDirectorDashboardScreen)...");
    cy.visitWithSemantics("/executive/hr-director-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrdirectordashboard-screen").should("be.visible");
    cy.getCy("hrdirectordashboard-title").should("be.visible");
    cy.getCy("hrdirectordashboard-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_director_dashboard");

    // [3/7] - Screen: HrDirectorHiringPipelineScreen (hr_director_hiring_pipeline)
    cy.task("log", "PROGRESS: Visiting /executive/hr-director-hiring-pipeline (HrDirectorHiringPipelineScreen)...");
    cy.visitWithSemantics("/executive/hr-director-hiring-pipeline");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrdirectorhiringpipeline-screen").should("be.visible");
    cy.getCy("hrdirectorhiringpipeline-title").should("be.visible");
    cy.getCy("hrdirectorhiringpipeline-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_director_hiring_pipeline");

    // [4/7] - Screen: HrDirectorOnboardingScreen (hr_director_onboarding)
    cy.task("log", "PROGRESS: Visiting /executive/hr-director-onboarding (HrDirectorOnboardingScreen)...");
    cy.visitWithSemantics("/executive/hr-director-onboarding");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrdirectoronboarding-screen").should("be.visible");
    cy.getCy("hrdirectoronboarding-title").should("be.visible");
    cy.getCy("hrdirectoronboarding-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_director_onboarding");

    // [5/7] - Screen: HrDirectorStaffFilesScreen (hr_director_staff_files)
    cy.task("log", "PROGRESS: Visiting /executive/hr-director-staff-files (HrDirectorStaffFilesScreen)...");
    cy.visitWithSemantics("/executive/hr-director-staff-files");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
    cy.getCy("hrdirectorstafffiles-title").should("be.visible");
    cy.getCy("hrdirectorstafffiles-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_director_staff_files");

    // [6/7] - Screen: HrDirectorTrainingScreen (hr_director_training)
    cy.task("log", "PROGRESS: Visiting /executive/hr-director-training (HrDirectorTrainingScreen)...");
    cy.visitWithSemantics("/executive/hr-director-training");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrdirectortraining-screen").should("be.visible");
    cy.getCy("hrdirectortraining-title").should("be.visible");
    cy.getCy("hrdirectortraining-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_director_training");

    // [7/7] - Screen: HrManagerDashboardScreen (hr_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /staff/hr-manager-dashboard (HrManagerDashboardScreen)...");
    cy.visitWithSemantics("/staff/hr-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("hrmanagerdashboard-screen").should("be.visible");
    cy.getCy("hrmanagerdashboard-title").should("be.visible");
    cy.getCy("hrmanagerdashboard-content").should("be.visible");
    cy.screenshot("co_hr_director_hr_manager_dashboard");
  });
});
