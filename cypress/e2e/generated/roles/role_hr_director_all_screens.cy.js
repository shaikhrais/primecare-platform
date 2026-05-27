// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.hr_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - hr_director", () => {
  it("tests all screens for role hr_director", () => {
    login();


  cy.visit("/executive/hr-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_dashboard");

  cy.visit("/staff/hr-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="hrmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_manager_dashboard");

  cy.visit("/executive/hr-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_analytics");

  cy.visit("/executive/hr-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_compliance");

  cy.visit("/executive/hr-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_workflow");

  cy.visit("/staff/hr-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="hrmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_manager_analytics");

  cy.visit("/staff/hr-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="hrmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_manager_compliance");

  cy.visit("/staff/hr-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="hrmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_manager_workflow");

  cy.visit("/executive/hr-director-hiring-pipeline");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectorhiringpipeline-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorhiringpipeline-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorhiringpipeline-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_hiring_pipeline");

  cy.visit("/executive/hr-director-staff-files");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectorstafffiles-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorstafffiles-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorstafffiles-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_staff_files");

  cy.visit("/executive/hr-director-training");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectortraining-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectortraining-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectortraining-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_training");

  cy.visit("/executive/hr-director-credential-expiry");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectorcredentialexpiry-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorcredentialexpiry-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectorcredentialexpiry-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_credential_expiry");

  cy.visit("/executive/hr-director-onboarding");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrdirectoronboarding-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectoronboarding-title"]`).should("be.visible");
  cy.get(`[data-cy="hrdirectoronboarding-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_director_onboarding");

  cy.visit("/management/hiring-pipeline");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hiringpipeline-screen"]`).should("be.visible");
  cy.get(`[data-cy="hiringpipeline-title"]`).should("be.visible");
  cy.get(`[data-cy="hiringpipeline-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hiring_pipeline");

  cy.visit("/management/employee-records");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="employeerecords-screen"]`).should("be.visible");
  cy.get(`[data-cy="employeerecords-title"]`).should("be.visible");
  cy.get(`[data-cy="employeerecords-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("employee_records");

  cy.visit("/management/credential-expiry");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="credentialexpiry-screen"]`).should("be.visible");
  cy.get(`[data-cy="credentialexpiry-title"]`).should("be.visible");
  cy.get(`[data-cy="credentialexpiry-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("credential_expiry");

  cy.visit("/management/training-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_management");

  cy.visit("/management/onboarding");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="onboarding-screen"]`).should("be.visible");
  cy.get(`[data-cy="onboarding-title"]`).should("be.visible");
  cy.get(`[data-cy="onboarding-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("onboarding");

  });
});
