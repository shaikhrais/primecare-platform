// AUTO-GENERATED APP E2E SPEC. SYSTEMATICALLY GENERATED.
// Tests all allowed roles and their respective screens on the portal.
// Leverages reusable SSO commands and custom Semantics selector lookups.

describe("App All Roles All Screens - Primecare Franchise", () => {

  it("verifies operation flow for role: OWNER", () => {
    cy.loginAsRole("owner");

    // [1/16] - Screen: AppointmentOverviewScreen (appointment_overview)
    cy.task("log", "PROGRESS: Visiting /executive/appointment-overview (AppointmentOverviewScreen)...");
    cy.visitWithSemantics("/executive/appointment-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("appointmentoverview-screen").should("be.visible");
    cy.getCy("appointmentoverview-title").should("be.visible");
    cy.getCy("appointmentoverview-content").should("be.visible");
    cy.screenshot("fr_owner_appointment_overview");

    // [2/16] - Screen: ComplianceOverviewScreen (compliance_overview)
    cy.task("log", "PROGRESS: Visiting /executive/compliance-overview (ComplianceOverviewScreen)...");
    cy.visitWithSemantics("/executive/compliance-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("complianceoverview-screen").should("be.visible");
    cy.getCy("complianceoverview-title").should("be.visible");
    cy.getCy("complianceoverview-content").should("be.visible");
    cy.screenshot("fr_owner_compliance_overview");

    // [3/16] - Screen: FranchiseCommandCenterScreen (franchise_command_center)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-command-center (FranchiseCommandCenterScreen)...");
    cy.visitWithSemantics("/executive/franchise-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchisecommandcenter-screen").should("be.visible");
    cy.getCy("franchisecommandcenter-title").should("be.visible");
    cy.getCy("franchisecommandcenter-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_command_center");

    // [4/16] - Screen: FranchiseCommandCenter4KScreen (franchise_command_center4_k)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-command-center4-k (FranchiseCommandCenter4KScreen)...");
    cy.visitWithSemantics("/executive/franchise-command-center4-k");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
    cy.getCy("franchisecommandcenter4k-title").should("be.visible");
    cy.getCy("franchisecommandcenter4k-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_command_center4_k");

    // [5/16] - Screen: FranchiseDashboardScreen (franchise_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/franchise-dashboard (FranchiseDashboardScreen)...");
    cy.visitWithSemantics("/common/franchise-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchisedashboard-screen").should("be.visible");
    cy.getCy("franchisedashboard-title").should("be.visible");
    cy.getCy("franchisedashboard-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_dashboard");

    // [6/16] - Screen: FranchiseOwnerAppointmentsScreen (franchise_owner_appointments)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-appointments (FranchiseOwnerAppointmentsScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-appointments");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownerappointments-screen").should("be.visible");
    cy.getCy("franchiseownerappointments-title").should("be.visible");
    cy.getCy("franchiseownerappointments-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_appointments");

    // [7/16] - Screen: FranchiseOwnerBranchOverviewScreen (franchise_owner_branch_overview)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-branch-overview (FranchiseOwnerBranchOverviewScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-branch-overview");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
    cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
    cy.getCy("franchiseownerbranchoverview-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_branch_overview");

    // [8/16] - Screen: FranchiseOwnerClientsScreen (franchise_owner_clients)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-clients (FranchiseOwnerClientsScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-clients");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownerclients-screen").should("be.visible");
    cy.getCy("franchiseownerclients-title").should("be.visible");
    cy.getCy("franchiseownerclients-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_clients");

    // [9/16] - Screen: FranchiseOwnerCommandCenterScreen (franchise_owner_command_center)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-command-center (FranchiseOwnerCommandCenterScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-command-center");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
    cy.getCy("franchiseownercommandcenter-title").should("be.visible");
    cy.getCy("franchiseownercommandcenter-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_command_center");

    // [10/16] - Screen: FranchiseOwnerComplianceScreen (franchise_owner_compliance)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-compliance (FranchiseOwnerComplianceScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-compliance");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownercompliance-screen").should("be.visible");
    cy.getCy("franchiseownercompliance-title").should("be.visible");
    cy.getCy("franchiseownercompliance-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_compliance");

    // [11/16] - Screen: FranchiseOwnerFinanceSnapshotScreen (franchise_owner_finance_snapshot)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-finance-snapshot (FranchiseOwnerFinanceSnapshotScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
    cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
    cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_finance_snapshot");

    // [12/16] - Screen: FranchiseOwnerReportsScreen (franchise_owner_reports)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-reports (FranchiseOwnerReportsScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-reports");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownerreports-screen").should("be.visible");
    cy.getCy("franchiseownerreports-title").should("be.visible");
    cy.getCy("franchiseownerreports-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_reports");

    // [13/16] - Screen: FranchiseOwnerStaffScreen (franchise_owner_staff)
    cy.task("log", "PROGRESS: Visiting /executive/franchise-owner-staff (FranchiseOwnerStaffScreen)...");
    cy.visitWithSemantics("/executive/franchise-owner-staff");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiseownerstaff-screen").should("be.visible");
    cy.getCy("franchiseownerstaff-title").should("be.visible");
    cy.getCy("franchiseownerstaff-content").should("be.visible");
    cy.screenshot("fr_owner_franchise_owner_staff");

    // [14/16] - Screen: OwnerDashboardScreen (owner_dashboard)
    cy.task("log", "PROGRESS: Visiting /executive/owner-dashboard (OwnerDashboardScreen)...");
    cy.visitWithSemantics("/executive/owner-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("ownerdashboard-screen").should("be.visible");
    cy.getCy("ownerdashboard-title").should("be.visible");
    cy.getCy("ownerdashboard-content").should("be.visible");
    cy.screenshot("fr_owner_owner_dashboard");

    // [15/16] - Screen: RevenueSnapshotScreen (revenue_snapshot)
    cy.task("log", "PROGRESS: Visiting /executive/revenue-snapshot (RevenueSnapshotScreen)...");
    cy.visitWithSemantics("/executive/revenue-snapshot");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("revenuesnapshot-screen").should("be.visible");
    cy.getCy("revenuesnapshot-title").should("be.visible");
    cy.getCy("revenuesnapshot-content").should("be.visible");
    cy.screenshot("fr_owner_revenue_snapshot");

    // [16/16] - Screen: StaffManagementScreen (staff_management)
    cy.task("log", "PROGRESS: Visiting /executive/staff-management (StaffManagementScreen)...");
    cy.visitWithSemantics("/executive/staff-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("staffmanagement-screen").should("be.visible");
    cy.getCy("staffmanagement-title").should("be.visible");
    cy.getCy("staffmanagement-content").should("be.visible");
    cy.screenshot("fr_owner_staff_management");
  });

  it("verifies operation flow for role: FRANCHISE_SALES", () => {
    cy.loginAsRole("franchise_sales");

    // [1/1] - Screen: FranchiseSalesManagerDashboardScreen (franchise_sales_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/franchise-sales-manager-dashboard (FranchiseSalesManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/franchise-sales-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
    cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
    cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");
    cy.screenshot("fr_franchise_sales_franchise_sales_manager_dashboard");
  });
});
