// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - owner", () => {
  it("tests all screens for role owner", () => {
    cy.loginAsRole("owner");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Navigating to /common/franchise-dashboard (FranchiseDashboardScreen)...");
  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Checking shell & content for FranchiseDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Saving screenshot for FranchiseDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/21 | 4%] - Verified FranchiseDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Navigating to /offices/corporate/roles/owner/dashboard (OwnerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/owner/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Checking shell & content for OwnerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Saving screenshot for OwnerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/21 | 9%] - Verified OwnerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Navigating to /common/franchise-analytics (FranchiseAnalyticsScreen)...");
  cy.visitWithSemantics("/common/franchise-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Checking shell & content for FranchiseAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Saving screenshot for FranchiseAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/21 | 14%] - Verified FranchiseAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Navigating to /common/franchise-workflow (FranchiseWorkflowScreen)...");
  cy.visitWithSemantics("/common/franchise-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Checking shell & content for FranchiseWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Saving screenshot for FranchiseWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/21 | 19%] - Verified FranchiseWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Navigating to /executive/owner-analytics (OwnerAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Checking shell & content for OwnerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Saving screenshot for OwnerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/21 | 23%] - Verified OwnerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Navigating to /executive/owner-workflow (OwnerWorkflowScreen)...");
  cy.visitWithSemantics("/executive/owner-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Checking shell & content for OwnerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Saving screenshot for OwnerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/21 | 28%] - Verified OwnerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Navigating to /executive/franchise-owner-command-center (FranchiseOwnerCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Checking shell & content for FranchiseOwnerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Saving screenshot for FranchiseOwnerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/21 | 33%] - Verified FranchiseOwnerCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Navigating to /offices/franchise/roles/franchise_owner/branch-overview (FranchiseOwnerBranchOverviewScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/branch-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Checking shell & content for FranchiseOwnerBranchOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Saving screenshot for FranchiseOwnerBranchOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/21 | 38%] - Verified FranchiseOwnerBranchOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Navigating to /offices/franchise/roles/franchise_owner/staff (FranchiseOwnerStaffScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/staff");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Checking shell & content for FranchiseOwnerStaffScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerstaff-screen").should("be.visible");
  cy.getCy("franchiseownerstaff-title").should("be.visible");
  cy.getCy("franchiseownerstaff-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Saving screenshot for FranchiseOwnerStaffScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_staff");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/21 | 42%] - Verified FranchiseOwnerStaffScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Navigating to /offices/franchise/roles/franchise_owner/clients (FranchiseOwnerClientsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/clients");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Checking shell & content for FranchiseOwnerClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerclients-screen").should("be.visible");
  cy.getCy("franchiseownerclients-title").should("be.visible");
  cy.getCy("franchiseownerclients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Saving screenshot for FranchiseOwnerClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/21 | 47%] - Verified FranchiseOwnerClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Navigating to /offices/franchise/roles/franchise_owner/appointments (FranchiseOwnerAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Checking shell & content for FranchiseOwnerAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Saving screenshot for FranchiseOwnerAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/21 | 52%] - Verified FranchiseOwnerAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Navigating to /executive/franchise-owner-finance-snapshot (FranchiseOwnerFinanceSnapshotScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Checking shell & content for FranchiseOwnerFinanceSnapshotScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Saving screenshot for FranchiseOwnerFinanceSnapshotScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_finance_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/21 | 57%] - Verified FranchiseOwnerFinanceSnapshotScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Navigating to /offices/franchise/roles/franchise_owner/reports (FranchiseOwnerReportsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Checking shell & content for FranchiseOwnerReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerreports-screen").should("be.visible");
  cy.getCy("franchiseownerreports-title").should("be.visible");
  cy.getCy("franchiseownerreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Saving screenshot for FranchiseOwnerReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/21 | 61%] - Verified FranchiseOwnerReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Navigating to /executive/franchise-command-center (FranchiseCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Checking shell & content for FranchiseCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Saving screenshot for FranchiseCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/21 | 66%] - Verified FranchiseCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Navigating to /executive/revenue-snapshot (RevenueSnapshotScreen)...");
  cy.visitWithSemantics("/executive/revenue-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Checking shell & content for RevenueSnapshotScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenuesnapshot-screen").should("be.visible");
  cy.getCy("revenuesnapshot-title").should("be.visible");
  cy.getCy("revenuesnapshot-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Saving screenshot for RevenueSnapshotScreen...");
  cy.waitAndSee();
  cy.screenshot("revenue_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/21 | 71%] - Verified RevenueSnapshotScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Navigating to /executive/staff-management (StaffManagementScreen)...");
  cy.visitWithSemantics("/executive/staff-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Checking shell & content for StaffManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Saving screenshot for StaffManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/21 | 76%] - Verified StaffManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Navigating to /executive/appointment-overview (AppointmentOverviewScreen)...");
  cy.visitWithSemantics("/executive/appointment-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Checking shell & content for AppointmentOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointmentoverview-screen").should("be.visible");
  cy.getCy("appointmentoverview-title").should("be.visible");
  cy.getCy("appointmentoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Saving screenshot for AppointmentOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("appointment_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/21 | 80%] - Verified AppointmentOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Navigating to /executive/franchise-command-center4-k (FranchiseCommandCenter4KScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Checking shell & content for FranchiseCommandCenter4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Saving screenshot for FranchiseCommandCenter4KScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/21 | 85%] - Verified FranchiseCommandCenter4KScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Navigating to /offices/franchise/roles/franchise_owner/dashboard (Franchise Owner Dashboard)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Checking shell & content for Franchise Owner Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise owner dashboard-screen").should("be.visible");
  cy.getCy("franchise owner dashboard-title").should("be.visible");
  cy.getCy("franchise owner dashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Saving screenshot for Franchise Owner Dashboard...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/21 | 90%] - Verified Franchise Owner Dashboard successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Navigating to /offices/franchise/roles/franchise_owner/financial-snapshot (Franchise Owner Financial Snapshot)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/financial-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Checking shell & content for Franchise Owner Financial Snapshot...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise owner financial snapshot-screen").should("be.visible");
  cy.getCy("franchise owner financial snapshot-title").should("be.visible");
  cy.getCy("franchise owner financial snapshot-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Saving screenshot for Franchise Owner Financial Snapshot...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_financial_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/21 | 95%] - Verified Franchise Owner Financial Snapshot successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Navigating to /offices/franchise/roles/franchise_owner/hiring (Franchise Owner Hiring)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/hiring");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Checking shell & content for Franchise Owner Hiring...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise owner hiring-screen").should("be.visible");
  cy.getCy("franchise owner hiring-title").should("be.visible");
  cy.getCy("franchise owner hiring-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Saving screenshot for Franchise Owner Hiring...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_hiring");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [21/21 | 100%] - Verified Franchise Owner Hiring successfully!\n");

  });
});
