// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.owner@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - owner", () => {
  it("tests all screens for role owner", () => {
    login();


  cy.visit("/common/franchise-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_dashboard");

  cy.visit("/executive/owner-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ownerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="ownerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="ownerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("owner_dashboard");

  cy.visit("/common/franchise-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_analytics");

  cy.visit("/common/franchise-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_compliance");

  cy.visit("/common/franchise-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_workflow");

  cy.visit("/executive/owner-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="owneranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="owneranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="owneranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("owner_analytics");

  cy.visit("/executive/owner-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ownercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="ownercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="ownercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("owner_compliance");

  cy.visit("/executive/owner-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ownerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="ownerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="ownerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("owner_workflow");

  cy.visit("/management/franchise-sales-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisesalesmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_manager_analytics");

  cy.visit("/management/franchise-sales-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisesalesmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_manager_compliance");

  cy.visit("/management/franchise-sales-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisesalesmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_manager_workflow");

  cy.visit("/executive/franchise-owner-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownercommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownercommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownercommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_command_center");

  cy.visit("/executive/franchise-owner-branch-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownerbranchoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerbranchoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerbranchoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_branch_overview");

  cy.visit("/executive/franchise-owner-staff");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownerstaff-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerstaff-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerstaff-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_staff");

  cy.visit("/executive/franchise-owner-clients");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownerclients-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerclients-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerclients-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_clients");

  cy.visit("/executive/franchise-owner-appointments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownerappointments-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerappointments-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerappointments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_appointments");

  cy.visit("/executive/franchise-owner-finance-snapshot");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownerfinancesnapshot-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerfinancesnapshot-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerfinancesnapshot-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_finance_snapshot");

  cy.visit("/executive/franchise-owner-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_compliance");

  cy.visit("/executive/franchise-owner-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseownerreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerreports-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseownerreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_owner_reports");

  cy.visit("/executive/franchise-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisecommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisecommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisecommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_command_center");

  cy.visit("/executive/revenue-snapshot");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="revenuesnapshot-screen"]`).should("be.visible");
  cy.get(`[data-cy="revenuesnapshot-title"]`).should("be.visible");
  cy.get(`[data-cy="revenuesnapshot-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("revenue_snapshot");

  cy.visit("/executive/staff-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="staffmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_management");

  cy.visit("/executive/appointment-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="appointmentoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="appointmentoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="appointmentoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("appointment_overview");

  cy.visit("/executive/compliance-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="complianceoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="complianceoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="complianceoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_overview");

  cy.visit("/executive/franchise-command-center4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisecommandcenter4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisecommandcenter4k-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisecommandcenter4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_command_center4_k");

  });
});
