// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - owner", () => {
  it("tests all screens for role owner", () => {
    cy.loginAsRole("owner");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Navigating to /common/franchise-dashboard (FranchiseDashboardScreen)...");
  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Checking shell & content for FranchiseDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Saving screenshot for FranchiseDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Verified FranchiseDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Navigating to /executive/owner-dashboard (OwnerDashboardScreen)...");
  cy.visitWithSemantics("/executive/owner-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Checking shell & content for OwnerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Saving screenshot for OwnerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Verified OwnerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Navigating to /common/franchise-analytics (FranchiseAnalyticsScreen)...");
  cy.visitWithSemantics("/common/franchise-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Checking shell & content for FranchiseAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Saving screenshot for FranchiseAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Verified FranchiseAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Navigating to /common/franchise-compliance (FranchiseComplianceScreen)...");
  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Checking shell & content for FranchiseComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Saving screenshot for FranchiseComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Verified FranchiseComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Navigating to /common/franchise-workflow (FranchiseWorkflowScreen)...");
  cy.visitWithSemantics("/common/franchise-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Checking shell & content for FranchiseWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Saving screenshot for FranchiseWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Verified FranchiseWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Navigating to /executive/owner-analytics (OwnerAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Checking shell & content for OwnerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Saving screenshot for OwnerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Verified OwnerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Navigating to /executive/owner-compliance (OwnerComplianceScreen)...");
  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Checking shell & content for OwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Saving screenshot for OwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Verified OwnerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Navigating to /executive/owner-workflow (OwnerWorkflowScreen)...");
  cy.visitWithSemantics("/executive/owner-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Checking shell & content for OwnerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Saving screenshot for OwnerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Verified OwnerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Navigating to /management/franchise-sales-manager-analytics (FranchiseSalesManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Checking shell & content for FranchiseSalesManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanageranalytics-screen").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-title").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Saving screenshot for FranchiseSalesManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Verified FranchiseSalesManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Navigating to /management/franchise-sales-manager-compliance (FranchiseSalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Checking shell & content for FranchiseSalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Saving screenshot for FranchiseSalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Verified FranchiseSalesManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Navigating to /management/franchise-sales-manager-workflow (FranchiseSalesManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Checking shell & content for FranchiseSalesManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-title").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Saving screenshot for FranchiseSalesManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Verified FranchiseSalesManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Navigating to /executive/franchise-owner-command-center (FranchiseOwnerCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Checking shell & content for FranchiseOwnerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Saving screenshot for FranchiseOwnerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Verified FranchiseOwnerCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Navigating to /executive/franchise-owner-branch-overview (FranchiseOwnerBranchOverviewScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-branch-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Checking shell & content for FranchiseOwnerBranchOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Saving screenshot for FranchiseOwnerBranchOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Verified FranchiseOwnerBranchOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Navigating to /executive/franchise-owner-staff (FranchiseOwnerStaffScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-staff");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Checking shell & content for FranchiseOwnerStaffScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerstaff-screen").should("be.visible");
  cy.getCy("franchiseownerstaff-title").should("be.visible");
  cy.getCy("franchiseownerstaff-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Saving screenshot for FranchiseOwnerStaffScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_staff");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Verified FranchiseOwnerStaffScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Navigating to /executive/franchise-owner-clients (FranchiseOwnerClientsScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-clients");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Checking shell & content for FranchiseOwnerClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerclients-screen").should("be.visible");
  cy.getCy("franchiseownerclients-title").should("be.visible");
  cy.getCy("franchiseownerclients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Saving screenshot for FranchiseOwnerClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Verified FranchiseOwnerClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Navigating to /executive/franchise-owner-appointments (FranchiseOwnerAppointmentsScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Checking shell & content for FranchiseOwnerAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Saving screenshot for FranchiseOwnerAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Verified FranchiseOwnerAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Navigating to /executive/franchise-owner-finance-snapshot (FranchiseOwnerFinanceSnapshotScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Checking shell & content for FranchiseOwnerFinanceSnapshotScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Saving screenshot for FranchiseOwnerFinanceSnapshotScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_finance_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Verified FranchiseOwnerFinanceSnapshotScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Navigating to /executive/franchise-owner-compliance (FranchiseOwnerComplianceScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Checking shell & content for FranchiseOwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercompliance-screen").should("be.visible");
  cy.getCy("franchiseownercompliance-title").should("be.visible");
  cy.getCy("franchiseownercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Saving screenshot for FranchiseOwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Verified FranchiseOwnerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Navigating to /executive/franchise-owner-reports (FranchiseOwnerReportsScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Checking shell & content for FranchiseOwnerReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerreports-screen").should("be.visible");
  cy.getCy("franchiseownerreports-title").should("be.visible");
  cy.getCy("franchiseownerreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Saving screenshot for FranchiseOwnerReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Verified FranchiseOwnerReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Navigating to /executive/franchise-command-center (FranchiseCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Checking shell & content for FranchiseCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Saving screenshot for FranchiseCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Verified FranchiseCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Navigating to /executive/revenue-snapshot (RevenueSnapshotScreen)...");
  cy.visitWithSemantics("/executive/revenue-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Checking shell & content for RevenueSnapshotScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenuesnapshot-screen").should("be.visible");
  cy.getCy("revenuesnapshot-title").should("be.visible");
  cy.getCy("revenuesnapshot-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Saving screenshot for RevenueSnapshotScreen...");
  cy.waitAndSee();
  cy.screenshot("revenue_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Verified RevenueSnapshotScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Navigating to /executive/staff-management (StaffManagementScreen)...");
  cy.visitWithSemantics("/executive/staff-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Checking shell & content for StaffManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Saving screenshot for StaffManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Verified StaffManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Navigating to /executive/appointment-overview (AppointmentOverviewScreen)...");
  cy.visitWithSemantics("/executive/appointment-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Checking shell & content for AppointmentOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointmentoverview-screen").should("be.visible");
  cy.getCy("appointmentoverview-title").should("be.visible");
  cy.getCy("appointmentoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Saving screenshot for AppointmentOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("appointment_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Verified AppointmentOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Navigating to /executive/compliance-overview (ComplianceOverviewScreen)...");
  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Checking shell & content for ComplianceOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Saving screenshot for ComplianceOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Verified ComplianceOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Navigating to /executive/franchise-command-center4-k (FranchiseCommandCenter4KScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Checking shell & content for FranchiseCommandCenter4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Saving screenshot for FranchiseCommandCenter4KScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Verified FranchiseCommandCenter4KScreen successfully!\n");

  });
});
