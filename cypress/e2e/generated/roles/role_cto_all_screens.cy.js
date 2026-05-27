// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.cto@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - cto", () => {
  it("tests all screens for role cto", () => {
    login();


  cy.visit("/clinical/clinical-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_dashboard");

  cy.visit("/common/architecture-planning-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanningdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_dashboard");

  cy.visit("/common/chiropractor-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_dashboard");

  cy.visit("/common/clinic-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_dashboard");

  cy.visit("/common/course-architect-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_dashboard");

  cy.visit("/executive/cto-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ctodashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="ctodashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="ctodashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cto_dashboard");

  cy.visit("/executive/cx-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_dashboard");

  cy.visit("/executive/finance-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_dashboard");

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

  cy.visit("/executive/training-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_dashboard");

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

  cy.visit("/clinical/clinical-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_analytics");

  cy.visit("/clinical/clinical-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_compliance");

  cy.visit("/clinical/clinical-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_workflow");

  cy.visit("/common/chiropractor-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_analytics");

  cy.visit("/common/chiropractor-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_compliance");

  cy.visit("/common/chiropractor-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_workflow");

  cy.visit("/common/clinic-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_analytics");

  cy.visit("/common/clinic-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cliniccompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cliniccompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cliniccompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_compliance");

  cy.visit("/common/clinic-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_workflow");

  cy.visit("/common/course-architect-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_analytics");

  cy.visit("/common/course-architect-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_compliance");

  cy.visit("/common/course-architect-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_workflow");

  cy.visit("/executive/cto-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ctoanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="ctoanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="ctoanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cto_analytics");

  cy.visit("/executive/cto-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ctocompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="ctocompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="ctocompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cto_compliance");

  cy.visit("/executive/cto-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ctoworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="ctoworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="ctoworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cto_workflow");

  cy.visit("/executive/cx-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_analytics");

  cy.visit("/executive/cx-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_compliance");

  cy.visit("/executive/cx-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_workflow");

  cy.visit("/executive/finance-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_analytics");

  cy.visit("/executive/finance-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_compliance");

  cy.visit("/executive/finance-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_workflow");

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

  cy.visit("/allied/chiropractor-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_command_center");

  cy.visit("/allied/chiropractor-appointments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorappointments-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorappointments-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorappointments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_appointments");

  cy.visit("/allied/chiropractor-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_client_intake");

  cy.visit("/allied/chiropractor-assessment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorassessment-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorassessment-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorassessment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_assessment");

  cy.visit("/allied/chiropractor-treatment-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractortreatmentnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractortreatmentnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractortreatmentnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_treatment_notes");

  cy.visit("/allied/chiropractor-exercise-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorexerciseplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorexerciseplan-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorexerciseplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_exercise_plan");

  cy.visit("/allied/chiropractor-billing-link");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorbillinglink-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorbillinglink-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorbillinglink-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_billing_link");

  cy.visit("/allied/chiropractor-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropractorreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorreports-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropractorreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractor_reports");

  cy.visit("/clinical/clinical-director-staff-quality");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorstaffquality-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorstaffquality-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorstaffquality-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_staff_quality");

  cy.visit("/clinical/clinical-director-incident-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorincidentreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorincidentreview-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorincidentreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_incident_review");

  cy.visit("/clinical/clinical-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_compliance");

  cy.visit("/clinical/clinical-director-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorreports-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_reports");

  cy.visit("/clinical/clinical-director-approvals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorapprovals-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorapprovals-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorapprovals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_approvals");

  cy.visit("/clinical/clinical-director-performance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorperformance-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorperformance-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorperformance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_performance");

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

  cy.visit("/executive/system-health");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemhealth-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemhealth-title"]`).should("be.visible");
  cy.get(`[data-cy="systemhealth-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_health");

  cy.visit("/executive/api-monitoring");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="apimonitoring-screen"]`).should("be.visible");
  cy.get(`[data-cy="apimonitoring-title"]`).should("be.visible");
  cy.get(`[data-cy="apimonitoring-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("api_monitoring");

  cy.visit("/executive/deployment-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="deploymentcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="deploymentcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="deploymentcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("deployment_center");

  cy.visit("/executive/security-audit");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="securityaudit-screen"]`).should("be.visible");
  cy.get(`[data-cy="securityaudit-title"]`).should("be.visible");
  cy.get(`[data-cy="securityaudit-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("security_audit");

  cy.visit("/executive/release-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="releasemanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="releasemanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="releasemanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("release_management");

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

  cy.visit("/allied/chiropractic-assessment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropracticassessment-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropracticassessment-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropracticassessment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractic_assessment");

  cy.visit("/allied/adjustment-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="adjustmentnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="adjustmentnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="adjustmentnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("adjustment_notes");

  cy.visit("/allied/xray-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="xrayreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="xrayreview-title"]`).should("be.visible");
  cy.get(`[data-cy="xrayreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("xray_review");

  cy.visit("/allied/chiropractic-progress-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="chiropracticprogresstracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="chiropracticprogresstracking-title"]`).should("be.visible");
  cy.get(`[data-cy="chiropracticprogresstracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("chiropractic_progress_tracking");

  cy.visit("/clinical/clinical-quality");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalquality-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalquality-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalquality-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_quality");

  cy.visit("/clinical/staff-performance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffperformance-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffperformance-title"]`).should("be.visible");
  cy.get(`[data-cy="staffperformance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_performance");

  cy.visit("/clinical/compliance-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancereview-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancereview-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancereview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_review");

  cy.visit("/clinical/incident-oversight");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentoversight-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentoversight-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentoversight-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_oversight");

  cy.visit("/clinical/clinical-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaloperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaloperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaloperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_operations4_k");

  });
});
