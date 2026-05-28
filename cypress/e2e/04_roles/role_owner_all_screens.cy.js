// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - owner", () => {
  it("tests all screens for role owner", () => {
    cy.loginAsRole("owner");


  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");

  cy.visitWithSemantics("/executive/owner-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_dashboard");

  cy.visitWithSemantics("/common/franchise-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_analytics");

  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_compliance");

  cy.visitWithSemantics("/common/franchise-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_workflow");

  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_analytics");

  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_compliance");

  cy.visitWithSemantics("/executive/owner-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_workflow");

  cy.visitWithSemantics("/management/franchise-sales-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanageranalytics-screen").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-title").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_analytics");

  cy.visitWithSemantics("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");

  cy.visitWithSemantics("/management/franchise-sales-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-title").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_workflow");

  cy.visitWithSemantics("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");

  cy.visitWithSemantics("/executive/franchise-owner-branch-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");

  cy.visitWithSemantics("/executive/franchise-owner-staff");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerstaff-screen").should("be.visible");
  cy.getCy("franchiseownerstaff-title").should("be.visible");
  cy.getCy("franchiseownerstaff-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_staff");

  cy.visitWithSemantics("/executive/franchise-owner-clients");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerclients-screen").should("be.visible");
  cy.getCy("franchiseownerclients-title").should("be.visible");
  cy.getCy("franchiseownerclients-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_clients");

  cy.visitWithSemantics("/executive/franchise-owner-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");

  cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_finance_snapshot");

  cy.visitWithSemantics("/executive/franchise-owner-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercompliance-screen").should("be.visible");
  cy.getCy("franchiseownercompliance-title").should("be.visible");
  cy.getCy("franchiseownercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_compliance");

  cy.visitWithSemantics("/executive/franchise-owner-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerreports-screen").should("be.visible");
  cy.getCy("franchiseownerreports-title").should("be.visible");
  cy.getCy("franchiseownerreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_reports");

  cy.visitWithSemantics("/executive/franchise-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_command_center");

  cy.visitWithSemantics("/executive/revenue-snapshot");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenuesnapshot-screen").should("be.visible");
  cy.getCy("revenuesnapshot-title").should("be.visible");
  cy.getCy("revenuesnapshot-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue_snapshot");

  cy.visitWithSemantics("/executive/staff-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_management");

  cy.visitWithSemantics("/executive/appointment-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointmentoverview-screen").should("be.visible");
  cy.getCy("appointmentoverview-title").should("be.visible");
  cy.getCy("appointmentoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("appointment_overview");

  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_overview");

  cy.visitWithSemantics("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");

  });
});
