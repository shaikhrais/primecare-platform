// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


describe("Org Full UI Test", () => {

  it("tests org role chiropractor", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.chiropractor@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

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
  });

  it("tests org role physio", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.physio@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/physiotherapist-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_dashboard");

  cy.visit("/common/physiotherapist-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_analytics");

  cy.visit("/common/physiotherapist-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_compliance");

  cy.visit("/common/physiotherapist-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_workflow");

  cy.visit("/allied/physiotherapist-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_command_center");

  cy.visit("/allied/physiotherapist-appointments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistappointments-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistappointments-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistappointments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_appointments");

  cy.visit("/allied/physiotherapist-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_client_intake");

  cy.visit("/allied/physiotherapist-assessment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistassessment-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistassessment-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistassessment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_assessment");

  cy.visit("/allied/physiotherapist-treatment-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapisttreatmentnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapisttreatmentnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapisttreatmentnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_treatment_notes");

  cy.visit("/allied/physiotherapist-exercise-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistexerciseplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistexerciseplan-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistexerciseplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_exercise_plan");

  cy.visit("/allied/physiotherapist-billing-link");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistbillinglink-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistbillinglink-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistbillinglink-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_billing_link");

  cy.visit("/allied/physiotherapist-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiotherapistreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistreports-title"]`).should("be.visible");
  cy.get(`[data-cy="physiotherapistreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physiotherapist_reports");

  cy.visit("/clinical/assessment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="assessment-screen"]`).should("be.visible");
  cy.get(`[data-cy="assessment-title"]`).should("be.visible");
  cy.get(`[data-cy="assessment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("assessment");

  cy.visit("/clinical/treatment-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="treatmentplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="treatmentplan-title"]`).should("be.visible");
  cy.get(`[data-cy="treatmentplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("treatment_plan");

  cy.visit("/clinical/exercise-prescription");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="exerciseprescription-screen"]`).should("be.visible");
  cy.get(`[data-cy="exerciseprescription-title"]`).should("be.visible");
  cy.get(`[data-cy="exerciseprescription-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("exercise_prescription");

  cy.visit("/clinical/progress-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="progresstracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="progresstracking-title"]`).should("be.visible");
  cy.get(`[data-cy="progresstracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("progress_tracking");
  });

  it("tests org role rmt", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.rmt@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/allied/rmt-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_dashboard");

  cy.visit("/allied/rmt-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_analytics");

  cy.visit("/allied/rmt-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_compliance");

  cy.visit("/allied/rmt-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_workflow");

  cy.visit("/allied/rmt-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_command_center");

  cy.visit("/allied/rmt-appointments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtappointments-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtappointments-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtappointments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_appointments");

  cy.visit("/allied/rmt-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_client_intake");

  cy.visit("/allied/rmt-assessment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtassessment-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtassessment-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtassessment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_assessment");

  cy.visit("/allied/rmt-treatment-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmttreatmentnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmttreatmentnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="rmttreatmentnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_treatment_notes");

  cy.visit("/allied/rmt-exercise-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtexerciseplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtexerciseplan-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtexerciseplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_exercise_plan");

  cy.visit("/allied/rmt-billing-link");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtbillinglink-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtbillinglink-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtbillinglink-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_billing_link");

  cy.visit("/allied/rmt-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rmtreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="rmtreports-title"]`).should("be.visible");
  cy.get(`[data-cy="rmtreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rmt_reports");

  cy.visit("/allied/massage-assessment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="massageassessment-screen"]`).should("be.visible");
  cy.get(`[data-cy="massageassessment-title"]`).should("be.visible");
  cy.get(`[data-cy="massageassessment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("massage_assessment");

  cy.visit("/allied/treatment-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="treatmentnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="treatmentnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="treatmentnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("treatment_notes");

  cy.visit("/allied/home-care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="homecareplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="homecareplan-title"]`).should("be.visible");
  cy.get(`[data-cy="homecareplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("home_care_plan");

  cy.visit("/allied/client-progress");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clientprogress-screen"]`).should("be.visible");
  cy.get(`[data-cy="clientprogress-title"]`).should("be.visible");
  cy.get(`[data-cy="clientprogress-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("client_progress");
  });

  it("tests org role social_worker", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.social_worker@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/social-worker-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_dashboard");

  cy.visit("/common/social-worker-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkeranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkeranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkeranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_analytics");

  cy.visit("/common/social-worker-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_compliance");

  cy.visit("/common/social-worker-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_workflow");
  });

  it("tests org role therapist", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.therapist@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/allied/therapist-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="therapistdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="therapistdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="therapistdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("therapist_dashboard");

  cy.visit("/allied/therapist-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="therapist analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="therapist analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="therapist analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("therapist_analytics");

  cy.visit("/allied/therapist-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="therapist compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="therapist compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="therapist compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("therapist_workflow");
  });

  it("tests org role clinical_director", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.clinical_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
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

  it("tests org role intake", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.intake@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/intake-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="intakedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_dashboard");

  cy.visit("/staff/intake-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_dashboard");

  cy.visit("/common/intake-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakeanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakeanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="intakeanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_analytics");

  cy.visit("/common/intake-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_compliance");

  cy.visit("/common/intake-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakeworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakeworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="intakeworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_workflow");

  cy.visit("/staff/intake-coordinator-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_analytics");

  cy.visit("/staff/intake-coordinator-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_compliance");

  cy.visit("/staff/intake-coordinator-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_workflow");

  cy.visit("/executive/referral-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="referralmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="referralmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="referralmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("referral_management");

  cy.visit("/executive/client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="clientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="clientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("client_intake");

  cy.visit("/executive/booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="booking-screen"]`).should("be.visible");
  cy.get(`[data-cy="booking-title"]`).should("be.visible");
  cy.get(`[data-cy="booking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("booking");

  cy.visit("/executive/followup");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="followup-screen"]`).should("be.visible");
  cy.get(`[data-cy="followup-title"]`).should("be.visible");
  cy.get(`[data-cy="followup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("followup");
  });

  it("tests org role rn", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.rn@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/system-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="systemdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_dashboard");

  cy.visit("/management/governance-officer-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_dashboard");

  cy.visit("/rn/rn-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rndashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rndashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rndashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_dashboard");

  cy.visit("/rn/rn-field-supervisor-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnfieldsupervisordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnfieldsupervisordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rnfieldsupervisordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_field_supervisor_dashboard");

  cy.visit("/management/governance-officer-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficeranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficeranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficeranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_analytics");

  cy.visit("/management/governance-officer-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_compliance");

  cy.visit("/management/governance-officer-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_workflow");

  cy.visit("/rn/rn-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="rnanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_analytics");

  cy.visit("/rn/rn-assessments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnassessments-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnassessments-title"]`).should("be.visible");
  cy.get(`[data-cy="rnassessments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_assessments");

  cy.visit("/rn/rn-care-plans");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rncareplans-screen"]`).should("be.visible");
  cy.get(`[data-cy="rncareplans-title"]`).should("be.visible");
  cy.get(`[data-cy="rncareplans-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_care_plans");

  cy.visit("/rn/rn-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rncompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="rncompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="rncompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_compliance");

  cy.visit("/rn/rn-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="rnworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_workflow");

  cy.visit("/rn/rn-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rncommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="rncommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="rncommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_command_center");

  cy.visit("/rn/rn-patient-charting");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnpatientcharting-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnpatientcharting-title"]`).should("be.visible");
  cy.get(`[data-cy="rnpatientcharting-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_patient_charting");

  cy.visit("/rn/rn-medications");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnmedications-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnmedications-title"]`).should("be.visible");
  cy.get(`[data-cy="rnmedications-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_medications");

  cy.visit("/rn/rn-vitals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnvitals-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnvitals-title"]`).should("be.visible");
  cy.get(`[data-cy="rnvitals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_vitals");

  cy.visit("/rn/rn-care-plan-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rncareplanreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="rncareplanreview-title"]`).should("be.visible");
  cy.get(`[data-cy="rncareplanreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_care_plan_review");

  cy.visit("/rn/rn-incident-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnincidentreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnincidentreview-title"]`).should("be.visible");
  cy.get(`[data-cy="rnincidentreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_incident_review");

  cy.visit("/rn/rn-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rntasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="rntasks-title"]`).should("be.visible");
  cy.get(`[data-cy="rntasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_tasks");

  cy.visit("/rn/rn-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnreports-title"]`).should("be.visible");
  cy.get(`[data-cy="rnreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_reports");

  cy.visit("/rn/patient-charting");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcharting-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcharting-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcharting-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_charting");

  cy.visit("/rn/medication-administration");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="medicationadministration-screen"]`).should("be.visible");
  cy.get(`[data-cy="medicationadministration-title"]`).should("be.visible");
  cy.get(`[data-cy="medicationadministration-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("medication_administration");

  cy.visit("/rn/care-plan-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="careplanreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="careplanreview-title"]`).should("be.visible");
  cy.get(`[data-cy="careplanreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("care_plan_review");

  cy.visit("/rn/incident-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentreview-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_review");

  cy.visit("/rn/shift-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shiftreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="shiftreport-title"]`).should("be.visible");
  cy.get(`[data-cy="shiftreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shift_report");

  cy.visit("/common/governance-control-room");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governancecontrolroom-screen"]`).should("be.visible");
  cy.get(`[data-cy="governancecontrolroom-title"]`).should("be.visible");
  cy.get(`[data-cy="governancecontrolroom-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_control_room");

  cy.visit("/common/runtime-verification");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="runtimeverification-screen"]`).should("be.visible");
  cy.get(`[data-cy="runtimeverification-title"]`).should("be.visible");
  cy.get(`[data-cy="runtimeverification-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("runtime_verification");

  cy.visit("/common/drift-findings");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="driftfindings-screen"]`).should("be.visible");
  cy.get(`[data-cy="driftfindings-title"]`).should("be.visible");
  cy.get(`[data-cy="driftfindings-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("drift_findings");

  cy.visit("/common/pending-task-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pendingtaskqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="pendingtaskqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="pendingtaskqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("pending_task_queue");

  cy.visit("/common/agent-dispatch");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="agentdispatch-screen"]`).should("be.visible");
  cy.get(`[data-cy="agentdispatch-title"]`).should("be.visible");
  cy.get(`[data-cy="agentdispatch-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("agent_dispatch");

  cy.visit("/common/audit");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="audit-screen"]`).should("be.visible");
  cy.get(`[data-cy="audit-title"]`).should("be.visible");
  cy.get(`[data-cy="audit-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("audit");

  cy.visit("/common/api-health-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="apihealthdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="apihealthdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="apihealthdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("api_health_dashboard");

  cy.visit("/common/release-operations");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="releaseoperations-screen"]`).should("be.visible");
  cy.get(`[data-cy="releaseoperations-title"]`).should("be.visible");
  cy.get(`[data-cy="releaseoperations-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("release_operations");

  cy.visit("/common/file-verification-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="fileverificationdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="fileverificationdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="fileverificationdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("file_verification_dashboard");

  cy.visit("/common/role-coverage-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rolecoveragedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rolecoveragedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rolecoveragedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("role_coverage_dashboard");

  cy.visit("/common/responsive-preview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="responsivepreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="responsivepreview-title"]`).should("be.visible");
  cy.get(`[data-cy="responsivepreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("responsive_preview");

  cy.visit("/common/workflow-execution");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="workflowexecution-screen"]`).should("be.visible");
  cy.get(`[data-cy="workflowexecution-title"]`).should("be.visible");
  cy.get(`[data-cy="workflowexecution-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("workflow_execution");

  cy.visit("/common/governance-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceoperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceoperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceoperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_operations4_k");

  cy.visit("/rn/rn-field-supervisor-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="registered nurse (rn) field supervisor analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_field_supervisor_analytics");

  cy.visit("/rn/rn-field-supervisor-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="registered nurse (rn) field supervisor compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_field_supervisor_workflow");
  });

  it("tests org role physician", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.physician@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/clinical/physician-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physiciandashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="physiciandashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="physiciandashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physician_dashboard");

  cy.visit("/clinical/physician-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physician analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="physician analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="physician analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physician_analytics");

  cy.visit("/clinical/physician-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="physician compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="physician compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="physician compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("physician_workflow");
  });

  it("tests org role cns", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.cns@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/clinical/cns-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cnsdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cnsdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cnsdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cns_dashboard");

  cy.visit("/rn/cns-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinical nurse specialist analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cns_analytics");

  cy.visit("/rn/cns-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinical nurse specialist compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cns_workflow");
  });

  it("tests org role pediatric", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.pediatric@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/clinical/pediatric-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pediatricdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="pediatricdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="pediatricdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("pediatric_dashboard");

  cy.visit("/clinical/pediatric-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pediatric specialist analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="pediatric specialist analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="pediatric specialist analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("pediatric_analytics");

  cy.visit("/clinical/pediatric-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pediatric specialist compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="pediatric specialist compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="pediatric specialist compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("pediatric_workflow");
  });

  it("tests org role caregiver", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.caregiver@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/caregiver-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_dashboard");

  cy.visit("/psw/caregiver-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregivertasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregivertasks-title"]`).should("be.visible");
  cy.get(`[data-cy="caregivertasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_tasks");

  cy.visit("/psw/caregiver-client-profile");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverclientprofile-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverclientprofile-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverclientprofile-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_client_profile");

  cy.visit("/psw/caregiver-visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregivervisitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregivervisitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="caregivervisitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_visit_notes");

  cy.visit("/psw/caregiver-schedule");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverschedule-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverschedule-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverschedule-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_schedule");

  cy.visit("/psw/caregiver-incident-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverincidentreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverincidentreport-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverincidentreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_incident_report");

  cy.visit("/psw/schedule");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedule-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedule-title"]`).should("be.visible");
  cy.get(`[data-cy="schedule-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("schedule");

  cy.visit("/psw/messaging");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="messaging-screen"]`).should("be.visible");
  cy.get(`[data-cy="messaging-title"]`).should("be.visible");
  cy.get(`[data-cy="messaging-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("messaging");
  });

  it("tests org role guest", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.guest@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/dynamic-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamicdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamicdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamicdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_screen_dashboard");

  cy.visit("/common/guest-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="guestdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_dashboard");

  cy.visit("/common/guest-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="guestanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_analytics");

  cy.visit("/common/guest-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="guestcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_compliance");

  cy.visit("/common/guest-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="guestworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_workflow");
  });

  it("tests org role portal", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.portal@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/portal-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portaldashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="portaldashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="portaldashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_dashboard");

  cy.visit("/common/portal-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portalanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="portalanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="portalanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_analytics");

  cy.visit("/common/portal-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portalcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="portalcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="portalcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_compliance");

  cy.visit("/common/portal-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portalworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="portalworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="portalworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_workflow");
  });

  it("tests org role patient", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.patient@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/family-member-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymemberdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymemberdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="familymemberdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_dashboard");

  cy.visit("/common/patient-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="patientdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_dashboard");

  cy.visit("/common/patient-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="patientanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_analytics");

  cy.visit("/common/patient-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_compliance");

  cy.visit("/common/patient-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="patientworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_workflow");

  cy.visit("/common/patient-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_command_center");

  cy.visit("/common/patient-appointments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientappointments-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientappointments-title"]`).should("be.visible");
  cy.get(`[data-cy="patientappointments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_appointments");

  cy.visit("/common/patient-care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcareplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcareplan-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcareplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_care_plan");

  cy.visit("/common/patient-messages");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientmessages-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientmessages-title"]`).should("be.visible");
  cy.get(`[data-cy="patientmessages-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_messages");

  cy.visit("/common/patient-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientdocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientdocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="patientdocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_documents");

  cy.visit("/common/patient-billing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientbilling-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientbilling-title"]`).should("be.visible");
  cy.get(`[data-cy="patientbilling-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_billing");

  cy.visit("/common/patient-profile");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientprofile-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientprofile-title"]`).should("be.visible");
  cy.get(`[data-cy="patientprofile-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_profile");

  cy.visit("/common/appointment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="appointment-screen"]`).should("be.visible");
  cy.get(`[data-cy="appointment-title"]`).should("be.visible");
  cy.get(`[data-cy="appointment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("appointment");

  cy.visit("/common/care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="careplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="careplan-title"]`).should("be.visible");
  cy.get(`[data-cy="careplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("care_plan");

  cy.visit("/common/billing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billing-screen"]`).should("be.visible");
  cy.get(`[data-cy="billing-title"]`).should("be.visible");
  cy.get(`[data-cy="billing-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing");

  cy.visit("/common/documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="documents-screen"]`).should("be.visible");
  cy.get(`[data-cy="documents-title"]`).should("be.visible");
  cy.get(`[data-cy="documents-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("documents");
  });

  it("tests org role dynamic", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.dynamic@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/customer-support-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_dashboard");

  cy.visit("/common/support-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="supportdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_dashboard");

  cy.visit("/common/dynamic-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamicanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamicanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamicanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_analytics");

  cy.visit("/common/dynamic-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamiccompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamiccompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamiccompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_compliance");

  cy.visit("/common/dynamic-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamicworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamicworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamicworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_workflow");

  cy.visit("/common/shared-stubs");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="sharedstubs-screen"]`).should("be.visible");
  cy.get(`[data-cy="sharedstubs-title"]`).should("be.visible");
  cy.get(`[data-cy="sharedstubs-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shared_stubs");
  });

  it("tests org role infrastructure", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.infrastructure@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/infrastructure-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructuredashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructuredashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructuredashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_dashboard");

  cy.visit("/common/architecture-planning-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanninganalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanninganalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanninganalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_analytics");

  cy.visit("/common/architecture-planning-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanningcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_compliance");

  cy.visit("/common/architecture-planning-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanningworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_workflow");

  cy.visit("/common/infrastructure-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructureanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_analytics");

  cy.visit("/common/infrastructure-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructurecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructurecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructurecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_compliance");

  cy.visit("/common/infrastructure-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructureworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_workflow");
  });

  it("tests org role system_verification", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.system_verification@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/qa-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qadashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="qadashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="qadashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("qa_dashboard");

  cy.visit("/common/system-verification-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_dashboard");

  cy.visit("/staff/quality-assurance-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qualityassurancedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="qualityassurancedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="qualityassurancedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("quality_assurance_dashboard");

  cy.visit("/common/system-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="systemanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_analytics");

  cy.visit("/common/system-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="systemcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_compliance");

  cy.visit("/common/system-verification-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_analytics");

  cy.visit("/common/system-verification-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_compliance");

  cy.visit("/common/system-verification-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_workflow");

  cy.visit("/common/system-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="systemworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_workflow");
  });

  it("tests org role training", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.training@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

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

  cy.visit("/common/training-hub-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_dashboard");

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

  cy.visit("/staff/training-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_dashboard");

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

  cy.visit("/common/training-hub-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_analytics");

  cy.visit("/common/training-hub-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_compliance");

  cy.visit("/common/training-hub-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_workflow");

  cy.visit("/executive/training-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_analytics");

  cy.visit("/executive/training-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_compliance");

  cy.visit("/executive/training-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_workflow");

  cy.visit("/staff/training-coordinator-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_analytics");

  cy.visit("/staff/training-coordinator-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_compliance");

  cy.visit("/staff/training-coordinator-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_workflow");

  cy.visit("/staff/training-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="courseassignment-screen"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-title"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="certificationtracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-title"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffprogress-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-title"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_progress");
  });

  it("tests org role ceo", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.ceo@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/executive/executive-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="executivecommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="executivecommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="executivecommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("executive_command_center");

  cy.visit("/executive/enterprise-health");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="enterprisehealth-screen"]`).should("be.visible");
  cy.get(`[data-cy="enterprisehealth-title"]`).should("be.visible");
  cy.get(`[data-cy="enterprisehealth-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("enterprise_health");

  cy.visit("/executive/revenue-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="revenueanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="revenueanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="revenueanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("revenue_analytics");

  cy.visit("/executive/risk-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="riskmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="riskmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="riskmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("risk_management");

  cy.visit("/executive/franchise-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_overview");

  cy.visit("/executive/enterprise-command-center4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="enterprisecommandcenter4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="enterprisecommandcenter4k-title"]`).should("be.visible");
  cy.get(`[data-cy="enterprisecommandcenter4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("enterprise_command_center4_k");
  });

  it("tests org role cfo", () => {

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

  it("tests org role ciso", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.ciso@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/executive/ciso-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisodashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisodashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cisodashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_dashboard");

  cy.visit("/executive/ciso-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisoanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisoanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cisoanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_analytics");

  cy.visit("/executive/ciso-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisocompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisocompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cisocompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_compliance");

  cy.visit("/executive/ciso-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisoworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisoworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cisoworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_workflow");
  });

  it("tests org role coo", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.coo@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/executive/coo-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coodashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="coodashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="coodashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_dashboard");

  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/executive/coo-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cooanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_analytics");

  cy.visit("/executive/coo-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coocompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="coocompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="coocompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_compliance");

  cy.visit("/executive/coo-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_workflow");

  cy.visit("/executive/coo-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coocommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="coocommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="coocommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_command_center");

  cy.visit("/executive/coo-operations-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coooperationsoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="coooperationsoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="coooperationsoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_operations_overview");

  cy.visit("/executive/coo-staffing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coostaffing-screen"]`).should("be.visible");
  cy.get(`[data-cy="coostaffing-title"]`).should("be.visible");
  cy.get(`[data-cy="coostaffing-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_staffing");

  cy.visit("/executive/coo-scheduling-health");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooschedulinghealth-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooschedulinghealth-title"]`).should("be.visible");
  cy.get(`[data-cy="cooschedulinghealth-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_scheduling_health");

  cy.visit("/executive/coo-workflow-issues");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooworkflowissues-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflowissues-title"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflowissues-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_workflow_issues");

  cy.visit("/executive/coo-branch-comparison");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coobranchcomparison-screen"]`).should("be.visible");
  cy.get(`[data-cy="coobranchcomparison-title"]`).should("be.visible");
  cy.get(`[data-cy="coobranchcomparison-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_branch_comparison");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorreferrals-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatornewclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorassessmentqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorbooking-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorfollowup-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_follow_up");

  cy.visit("/executive/operations-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="operationscommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="operationscommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="operationscommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("operations_command_center");

  cy.visit("/executive/staffing-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffingoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffingoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="staffingoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staffing_overview");

  cy.visit("/executive/workflow-issue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="workflowissue-screen"]`).should("be.visible");
  cy.get(`[data-cy="workflowissue-title"]`).should("be.visible");
  cy.get(`[data-cy="workflowissue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("workflow_issue");

  cy.visit("/executive/service-quality");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="servicequality-screen"]`).should("be.visible");
  cy.get(`[data-cy="servicequality-title"]`).should("be.visible");
  cy.get(`[data-cy="servicequality-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("service_quality");

  cy.visit("/executive/branch-performance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="branchperformance-screen"]`).should("be.visible");
  cy.get(`[data-cy="branchperformance-title"]`).should("be.visible");
  cy.get(`[data-cy="branchperformance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("branch_performance");

  cy.visit("/staff/training-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="courseassignment-screen"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-title"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="certificationtracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-title"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffprogress-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-title"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_progress");
  });

  it("tests org role cto", () => {

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

  it("tests org role cx_director", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.cx_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

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
  });

  it("tests org role finance_director", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.finance_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

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
  });

  it("tests org role hr_director", () => {

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

  it("tests org role legal", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.legal@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/executive/legal-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legaldashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="legaldashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="legaldashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_dashboard");

  cy.visit("/executive/legal-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legalanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="legalanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="legalanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_analytics");

  cy.visit("/executive/legal-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legalcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="legalcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="legalcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_compliance");

  cy.visit("/executive/legal-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legalworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="legalworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="legalworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_workflow");
  });

  it("tests org role owner", () => {

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

  it("tests org role shareholder", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.shareholder@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/executive/shareholder-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholderdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholderdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholderdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_dashboard");

  cy.visit("/executive/shareholder-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholderanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholderanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholderanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_analytics");

  cy.visit("/executive/shareholder-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholdercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholdercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholdercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_compliance");

  cy.visit("/executive/shareholder-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholderworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholderworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholderworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_workflow");
  });

  it("tests org role training_director", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.training_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

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
  });

  it("tests org role community_outreach", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.community_outreach@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/community-outreach-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_dashboard");

  cy.visit("/management/community-outreach-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_analytics");

  cy.visit("/management/community-outreach-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_compliance");

  cy.visit("/management/community-outreach-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_workflow");
  });

  it("tests org role compliance", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.compliance@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/compliance-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_dashboard");

  cy.visit("/management/compliance-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_analytics");

  cy.visit("/management/compliance-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_compliance");

  cy.visit("/management/compliance-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_workflow");

  cy.visit("/management/compliance-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_dashboard");

  cy.visit("/management/audit-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="auditreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="auditreview-title"]`).should("be.visible");
  cy.get(`[data-cy="auditreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("audit_review");

  cy.visit("/management/incident-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_management");

  cy.visit("/management/policy-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="policymanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="policymanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="policymanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("policy_management");

  cy.visit("/management/corrective-action");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="correctiveaction-screen"]`).should("be.visible");
  cy.get(`[data-cy="correctiveaction-title"]`).should("be.visible");
  cy.get(`[data-cy="correctiveaction-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("corrective_action");
  });

  it("tests org role franchise_sales", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.franchise_sales@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/franchise-sales-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisesalesmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_manager_dashboard");

  cy.visit("/executive/franchise-sales-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchise sales manager analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_analytics");

  cy.visit("/executive/franchise-sales-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchise sales manager compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_workflow");
  });

  it("tests org role gm", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.gm@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/general-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="generalmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="generalmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="generalmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("general_manager_dashboard");

  cy.visit("/management/general-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="generalmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="generalmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="generalmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("general_manager_analytics");

  cy.visit("/management/general-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="generalmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="generalmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="generalmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("general_manager_compliance");

  cy.visit("/management/general-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="generalmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="generalmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="generalmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("general_manager_workflow");
  });

  it("tests org role governance", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.governance@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/system-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="systemdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_dashboard");

  cy.visit("/management/governance-officer-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_dashboard");

  cy.visit("/management/governance-officer-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficeranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficeranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficeranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_analytics");

  cy.visit("/management/governance-officer-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_compliance");

  cy.visit("/management/governance-officer-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceofficerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceofficerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_officer_workflow");

  cy.visit("/common/governance-control-room");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governancecontrolroom-screen"]`).should("be.visible");
  cy.get(`[data-cy="governancecontrolroom-title"]`).should("be.visible");
  cy.get(`[data-cy="governancecontrolroom-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_control_room");

  cy.visit("/common/runtime-verification");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="runtimeverification-screen"]`).should("be.visible");
  cy.get(`[data-cy="runtimeverification-title"]`).should("be.visible");
  cy.get(`[data-cy="runtimeverification-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("runtime_verification");

  cy.visit("/common/drift-findings");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="driftfindings-screen"]`).should("be.visible");
  cy.get(`[data-cy="driftfindings-title"]`).should("be.visible");
  cy.get(`[data-cy="driftfindings-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("drift_findings");

  cy.visit("/common/pending-task-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pendingtaskqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="pendingtaskqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="pendingtaskqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("pending_task_queue");

  cy.visit("/common/agent-dispatch");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="agentdispatch-screen"]`).should("be.visible");
  cy.get(`[data-cy="agentdispatch-title"]`).should("be.visible");
  cy.get(`[data-cy="agentdispatch-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("agent_dispatch");

  cy.visit("/common/audit");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="audit-screen"]`).should("be.visible");
  cy.get(`[data-cy="audit-title"]`).should("be.visible");
  cy.get(`[data-cy="audit-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("audit");

  cy.visit("/common/api-health-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="apihealthdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="apihealthdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="apihealthdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("api_health_dashboard");

  cy.visit("/common/release-operations");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="releaseoperations-screen"]`).should("be.visible");
  cy.get(`[data-cy="releaseoperations-title"]`).should("be.visible");
  cy.get(`[data-cy="releaseoperations-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("release_operations");

  cy.visit("/common/file-verification-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="fileverificationdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="fileverificationdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="fileverificationdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("file_verification_dashboard");

  cy.visit("/common/role-coverage-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rolecoveragedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rolecoveragedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rolecoveragedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("role_coverage_dashboard");

  cy.visit("/common/responsive-preview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="responsivepreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="responsivepreview-title"]`).should("be.visible");
  cy.get(`[data-cy="responsivepreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("responsive_preview");

  cy.visit("/common/workflow-execution");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="workflowexecution-screen"]`).should("be.visible");
  cy.get(`[data-cy="workflowexecution-title"]`).should("be.visible");
  cy.get(`[data-cy="workflowexecution-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("workflow_execution");

  cy.visit("/common/governance-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="governanceoperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="governanceoperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="governanceoperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("governance_operations4_k");
  });

  it("tests org role bus_dev", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.bus_dev@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/business-development-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_dashboard");

  cy.visit("/management/head-of-bus-dev-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_dashboard");

  cy.visit("/common/business-development-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_analytics");

  cy.visit("/common/business-development-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_compliance");

  cy.visit("/common/business-development-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_workflow");

  cy.visit("/management/head-of-bus-dev-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_analytics");

  cy.visit("/management/head-of-bus-dev-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_compliance");

  cy.visit("/management/head-of-bus-dev-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_workflow");

  cy.visit("/management/franchise-lead");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiselead-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiselead-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiselead-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_lead");

  cy.visit("/management/partnership-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_management");

  cy.visit("/management/growth-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="growthanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="growthanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="growthanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("growth_analytics");

  cy.visit("/management/outreach-campaign");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="outreachcampaign-screen"]`).should("be.visible");
  cy.get(`[data-cy="outreachcampaign-title"]`).should("be.visible");
  cy.get(`[data-cy="outreachcampaign-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("outreach_campaign");
  });

  it("tests org role marketing", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.marketing@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/head-of-marketing-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_dashboard");

  cy.visit("/management/local-marketing-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visit("/management/head-of-marketing-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketinganalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketinganalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketinganalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_analytics");

  cy.visit("/management/head-of-marketing-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketingcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_compliance");

  cy.visit("/management/head-of-marketing-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketingworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_workflow");

  cy.visit("/management/local-marketing-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_analytics");

  cy.visit("/management/local-marketing-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_compliance");

  cy.visit("/management/local-marketing-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_workflow");

  cy.visit("/management/campaign-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="campaigndashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="campaigndashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="campaigndashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("campaign_dashboard");

  cy.visit("/management/lead-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="leadanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="leadanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="leadanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lead_analytics");

  cy.visit("/management/social-media");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialmedia-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialmedia-title"]`).should("be.visible");
  cy.get(`[data-cy="socialmedia-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_media");

  cy.visit("/management/brand-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="brandmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="brandmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="brandmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("brand_management");
  });

  it("tests org role local_marketing", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.local_marketing@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/local-marketing-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visit("/management/local-marketing-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_analytics");

  cy.visit("/management/local-marketing-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_compliance");

  cy.visit("/management/local-marketing-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_workflow");
  });

  it("tests org role ops_manager", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.ops_manager@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/operations-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="operationsmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("operations_manager_dashboard");

  cy.visit("/management/operations-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="operationsmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("operations_manager_analytics");

  cy.visit("/management/operations-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="operationsmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("operations_manager_compliance");

  cy.visit("/management/operations-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="operationsmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="operationsmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("operations_manager_workflow");

  cy.visit("/management/daily-operations");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dailyoperations-screen"]`).should("be.visible");
  cy.get(`[data-cy="dailyoperations-title"]`).should("be.visible");
  cy.get(`[data-cy="dailyoperations-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("daily_operations");

  cy.visit("/management/attendance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="attendance-screen"]`).should("be.visible");
  cy.get(`[data-cy="attendance-title"]`).should("be.visible");
  cy.get(`[data-cy="attendance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("attendance");

  cy.visit("/management/scheduling-health");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulinghealth-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulinghealth-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulinghealth-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduling_health");

  cy.visit("/management/service-issue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="serviceissue-screen"]`).should("be.visible");
  cy.get(`[data-cy="serviceissue-title"]`).should("be.visible");
  cy.get(`[data-cy="serviceissue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("service_issue");
  });

  it("tests org role partnership", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.partnership@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/partnership-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_dashboard");

  cy.visit("/management/partnership-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_analytics");

  cy.visit("/management/partnership-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_compliance");

  cy.visit("/management/partnership-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_workflow");
  });

  it("tests org role regional_bdm", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.regional_bdm@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/regional-bdm-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_dashboard");

  cy.visit("/management/regional-bdm-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_analytics");

  cy.visit("/management/regional-bdm-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_compliance");

  cy.visit("/management/regional-bdm-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_workflow");
  });

  it("tests org role regional_manager_usa", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.regional_manager_usa@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/regional-manager-usa-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusadashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusadashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusadashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_dashboard");

  cy.visit("/management/regional-manager-usa-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusaanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_analytics");

  cy.visit("/management/regional-manager-usa-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusacompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusacompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusacompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_compliance");

  cy.visit("/management/regional-manager-usa-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusaworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_workflow");
  });

  it("tests org role scrum_master", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.scrum_master@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/scrum-master-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummasterdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_dashboard");

  cy.visit("/management/scrum-master-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummasteranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummasteranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummasteranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_analytics");

  cy.visit("/management/scrum-master-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummastercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummastercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummastercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_compliance");

  cy.visit("/management/scrum-master-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummasterworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_workflow");
  });

  it("tests org role hr_hiring", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.hr_hiring@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/staff/hr-hiring-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_dashboard");

  cy.visit("/staff/hr-hiring-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_analytics");

  cy.visit("/staff/hr-hiring-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_compliance");

  cy.visit("/staff/hr-hiring-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_workflow");

  cy.visit("/staff/hr-hiring-applicants");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringapplicants-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringapplicants-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringapplicants-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_applicants");

  cy.visit("/staff/hr-hiring-interviews");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringinterviews-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringinterviews-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringinterviews-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_interviews");

  cy.visit("/staff/hr-hiring-offers");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringoffers-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringoffers-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringoffers-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_offers");

  cy.visit("/staff/hr-hiring-onboarding");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringonboarding-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringonboarding-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringonboarding-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_onboarding");

  cy.visit("/staff/hr-hiring-credentials");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringcredentials-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcredentials-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcredentials-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_credentials");

  cy.visit("/staff/applicant-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="applicanttracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="applicanttracking-title"]`).should("be.visible");
  cy.get(`[data-cy="applicanttracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("applicant_tracking");

  cy.visit("/staff/interview-scheduling");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="interviewscheduling-screen"]`).should("be.visible");
  cy.get(`[data-cy="interviewscheduling-title"]`).should("be.visible");
  cy.get(`[data-cy="interviewscheduling-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("interview_scheduling");

  cy.visit("/staff/offer-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="offermanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="offermanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="offermanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("offer_management");

  cy.visit("/staff/onboarding-checklist");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="onboardingchecklist-screen"]`).should("be.visible");
  cy.get(`[data-cy="onboardingchecklist-title"]`).should("be.visible");
  cy.get(`[data-cy="onboardingchecklist-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("onboarding_checklist");
  });

  it("tests org role territory_expansion", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.territory_expansion@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/territory-expansion-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_dashboard");

  cy.visit("/management/territory-expansion-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_analytics");

  cy.visit("/management/territory-expansion-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_compliance");

  cy.visit("/management/territory-expansion-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_workflow");
  });

  it("tests org role territory_sales", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.territory_sales@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/territory-sales-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_dashboard");

  cy.visit("/management/territory-sales-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_analytics");

  cy.visit("/management/territory-sales-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_compliance");

  cy.visit("/management/territory-sales-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_workflow");
  });

  it("tests org role volunteer_coordinator", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.volunteer_coordinator@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorreferrals-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatornewclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorassessmentqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorbooking-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorfollowup-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_follow_up");
  });

  it("tests org role premium_concierge", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.premium_concierge@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/premium-concierge-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="premiumconciergedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="premiumconciergedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="premiumconciergedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("premium_concierge_dashboard");

  cy.visit("/premium/premium-concierge-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="premium concierge care coordinator analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("premium_concierge_analytics");

  cy.visit("/premium/premium-concierge-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="premium concierge care coordinator compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("premium_concierge_workflow");
  });

  it("tests org role vip_manager", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.vip_manager@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/management/vip-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vipmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="vipmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="vipmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vip_manager_dashboard");

  cy.visit("/executive/vip-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vip client manager analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vip_manager_analytics");

  cy.visit("/executive/vip-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vip client manager compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vip_manager_workflow");
  });

  it("tests org role psw", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.psw@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/psw/psw-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="pswdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_dashboard");

  cy.visit("/psw/psw-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="pswanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_analytics");

  cy.visit("/psw/psw-clients");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswclients-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswclients-title"]`).should("be.visible");
  cy.get(`[data-cy="pswclients-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_clients");

  cy.visit("/psw/psw-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="pswcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_compliance");

  cy.visit("/psw/psw-messages");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswmessages-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-title"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_messages");

  cy.visit("/psw/psw-shift-tracker");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswshifttracker-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswshifttracker-title"]`).should("be.visible");
  cy.get(`[data-cy="pswshifttracker-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_shift_tracker");

  cy.visit("/psw/psw-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswtasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswtasks-title"]`).should("be.visible");
  cy.get(`[data-cy="pswtasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_tasks");

  cy.visit("/psw/psw-visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswvisitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_visit_notes");

  cy.visit("/psw/psw-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="pswworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_workflow");

  cy.visit("/psw/psw-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="pswcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_command_center");

  cy.visit("/psw/psw-my-shifts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswmyshifts-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswmyshifts-title"]`).should("be.visible");
  cy.get(`[data-cy="pswmyshifts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_my_shifts");

  cy.visit("/psw/psw-client-profile");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswclientprofile-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswclientprofile-title"]`).should("be.visible");
  cy.get(`[data-cy="pswclientprofile-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_client_profile");

  cy.visit("/psw/psw-visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswvisitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_visit_notes");

  cy.visit("/psw/psw-vitals-log");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswvitalslog-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswvitalslog-title"]`).should("be.visible");
  cy.get(`[data-cy="pswvitalslog-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_vitals_log");

  cy.visit("/psw/psw-incident-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswincidentreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswincidentreport-title"]`).should("be.visible");
  cy.get(`[data-cy="pswincidentreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_incident_report");

  cy.visit("/psw/psw-care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswcareplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswcareplan-title"]`).should("be.visible");
  cy.get(`[data-cy="pswcareplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_care_plan");

  cy.visit("/psw/psw-messages");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswmessages-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-title"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_messages");

  cy.visit("/psw/psw-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswdocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswdocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="pswdocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_documents");

  cy.visit("/psw/shift-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shifttasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="shifttasks-title"]`).should("be.visible");
  cy.get(`[data-cy="shifttasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shift_tasks");

  cy.visit("/psw/visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="visitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="visitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="visitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("visit_notes");

  cy.visit("/psw/vitals-entry");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vitalsentry-screen"]`).should("be.visible");
  cy.get(`[data-cy="vitalsentry-title"]`).should("be.visible");
  cy.get(`[data-cy="vitalsentry-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vitals_entry");

  cy.visit("/psw/incident-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentreport-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_report");
  });

  it("tests org role hsw", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.hsw@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/clinical/hsw-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="hswdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_dashboard");

  cy.visit("/clinical/hsw-adl-logger");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswadllogger-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswadllogger-title"]`).should("be.visible");
  cy.get(`[data-cy="hswadllogger-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_adl_logger");

  cy.visit("/clinical/hsw-care-plans");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswcareplans-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswcareplans-title"]`).should("be.visible");
  cy.get(`[data-cy="hswcareplans-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_care_plans");

  cy.visit("/clinical/hsw-incident-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswincidentreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswincidentreports-title"]`).should("be.visible");
  cy.get(`[data-cy="hswincidentreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_incident_reports");

  cy.visit("/clinical/hsw-schedule");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswschedule-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswschedule-title"]`).should("be.visible");
  cy.get(`[data-cy="hswschedule-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_schedule");
  });

  it("tests org role rn_field_supervisor", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.rn_field_supervisor@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/rn/rn-field-supervisor-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rnfieldsupervisordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rnfieldsupervisordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rnfieldsupervisordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_field_supervisor_dashboard");

  cy.visit("/rn/rn-field-supervisor-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="registered nurse (rn) field supervisor analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_field_supervisor_analytics");

  cy.visit("/rn/rn-field-supervisor-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="registered nurse (rn) field supervisor compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="registered nurse (rn) field supervisor compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rn_field_supervisor_workflow");
  });

  it("tests org role np", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.np@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/clinical/np-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="npdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="npdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="npdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("np_dashboard");

  cy.visit("/rn/np-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="nurse practitioner (np) analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("np_analytics");

  cy.visit("/rn/np-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="nurse practitioner (np) compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("np_workflow");
  });

  it("tests org role rpn", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.rpn@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/rpn/rpn-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpndashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpndashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="rpndashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_dashboard");

  cy.visit("/rpn/rpn-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_analytics");

  cy.visit("/rpn/rpn-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpncompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpncompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="rpncompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_compliance");

  cy.visit("/rpn/rpn-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_workflow");

  cy.visit("/rpn/rpn-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpncommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpncommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="rpncommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_command_center");

  cy.visit("/rpn/rpn-patient-charting");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnpatientcharting-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnpatientcharting-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnpatientcharting-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_patient_charting");

  cy.visit("/rpn/rpn-medications");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnmedications-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnmedications-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnmedications-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_medications");

  cy.visit("/rpn/rpn-vitals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnvitals-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnvitals-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnvitals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_vitals");

  cy.visit("/rpn/rpn-care-plan-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpncareplanreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpncareplanreview-title"]`).should("be.visible");
  cy.get(`[data-cy="rpncareplanreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_care_plan_review");

  cy.visit("/rpn/rpn-incident-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnincidentreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnincidentreview-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnincidentreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_incident_review");

  cy.visit("/rpn/rpn-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpntasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpntasks-title"]`).should("be.visible");
  cy.get(`[data-cy="rpntasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_tasks");

  cy.visit("/rpn/rpn-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="rpnreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="rpnreports-title"]`).should("be.visible");
  cy.get(`[data-cy="rpnreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("rpn_reports");

  cy.visit("/clinical/nursing-task");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="nursingtask-screen"]`).should("be.visible");
  cy.get(`[data-cy="nursingtask-title"]`).should("be.visible");
  cy.get(`[data-cy="nursingtask-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("nursing_task");

  cy.visit("/clinical/vitals-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vitalstracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="vitalstracking-title"]`).should("be.visible");
  cy.get(`[data-cy="vitalstracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vitals_tracking");

  cy.visit("/clinical/medication");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="medication-screen"]`).should("be.visible");
  cy.get(`[data-cy="medication-title"]`).should("be.visible");
  cy.get(`[data-cy="medication-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("medication");

  cy.visit("/clinical/patient-observation");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientobservation-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientobservation-title"]`).should("be.visible");
  cy.get(`[data-cy="patientobservation-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_observation");
  });

  it("tests org role lpn", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.lpn@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/clinical/lpn-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="lpndashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="lpndashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="lpndashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lpn_dashboard");

  cy.visit("/rpn/lpn-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="licensed practical nurse (lpn) analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lpn_analytics");

  cy.visit("/rpn/lpn-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="licensed practical nurse (lpn) compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lpn_workflow");
  });

  it("tests org role employee", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.employee@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/staff/employee-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="employeedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="employeedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="employeedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("employee_dashboard");

  cy.visit("/staff/employee-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="employee analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="employee analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="employee analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("employee_analytics");

  cy.visit("/staff/employee-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="employee compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="employee compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="employee compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("employee_workflow");
  });

  it("tests org role volunteer", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.volunteer@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/staff/volunteer-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_dashboard");

  cy.visit("/staff/volunteer-coordinator-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_analytics");

  cy.visit("/staff/volunteer-coordinator-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_compliance");

  cy.visit("/staff/volunteer-coordinator-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_workflow");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorreferrals-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatornewclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorassessmentqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorbooking-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorfollowup-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_follow_up");
  });

  it("tests org role admin", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.admin@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/office-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="officedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="officedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_dashboard");

  cy.visit("/staff/billing-admin-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadmindashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadmindashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadmindashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_dashboard");

  cy.visit("/staff/receptionist-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_dashboard");

  cy.visit("/common/office-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officeanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="officeanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="officeanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_analytics");

  cy.visit("/common/office-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="officecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="officecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_compliance");

  cy.visit("/common/office-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officeworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="officeworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="officeworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_workflow");

  cy.visit("/staff/billing-admin-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadminanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadminanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadminanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_analytics");

  cy.visit("/staff/billing-admin-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadmincompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadmincompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadmincompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_compliance");

  cy.visit("/staff/billing-admin-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadminworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadminworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadminworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_workflow");

  cy.visit("/staff/receptionist-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_analytics");

  cy.visit("/staff/receptionist-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_compliance");

  cy.visit("/staff/receptionist-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_workflow");

  cy.visit("/staff/invoice-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="invoicemanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="invoicemanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="invoicemanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("invoice_management");

  cy.visit("/staff/claims-processing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="claimsprocessing-screen"]`).should("be.visible");
  cy.get(`[data-cy="claimsprocessing-title"]`).should("be.visible");
  cy.get(`[data-cy="claimsprocessing-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("claims_processing");

  cy.visit("/staff/payment-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="paymenttracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="paymenttracking-title"]`).should("be.visible");
  cy.get(`[data-cy="paymenttracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("payment_tracking");

  cy.visit("/staff/refund-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="refundmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="refundmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="refundmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("refund_management");
  });

  it("tests org role scheduler", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.scheduler@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/staff/scheduler-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_dashboard");

  cy.visit("/staff/coordinator-dispatch-map");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatordispatchmap-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatordispatchmap-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatordispatchmap-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_dispatch_map");

  cy.visit("/staff/coordinator-hub");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatorhub-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorhub-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorhub-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_hub");

  cy.visit("/staff/coordinator-sos");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatorsos-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorsos-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorsos-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_sos");

  cy.visit("/staff/coordinator-waitlist");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatorwaitlist-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorwaitlist-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorwaitlist-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_waitlist");

  cy.visit("/staff/scheduler-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scheduleranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="scheduleranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="scheduleranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_analytics");

  cy.visit("/staff/scheduler-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_compliance");

  cy.visit("/staff/scheduler-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_workflow");

  cy.visit("/staff/scheduler-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulercommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulercommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulercommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_command_center");

  cy.visit("/staff/scheduler-calendar");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulercalendar-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulercalendar-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulercalendar-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_calendar");

  cy.visit("/staff/scheduler-booking-requests");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerbookingrequests-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerbookingrequests-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerbookingrequests-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_booking_requests");

  cy.visit("/staff/scheduler-conflicts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerconflicts-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerconflicts-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerconflicts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_conflicts");

  cy.visit("/staff/scheduler-open-shifts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scheduleropenshifts-screen"]`).should("be.visible");
  cy.get(`[data-cy="scheduleropenshifts-title"]`).should("be.visible");
  cy.get(`[data-cy="scheduleropenshifts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_open_shifts");

  cy.visit("/staff/scheduler-provider-availability");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerprovideravailability-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerprovideravailability-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerprovideravailability-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_provider_availability");

  cy.visit("/staff/scheduling-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduling_dashboard");

  cy.visit("/staff/calendar-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="calendarmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="calendarmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="calendarmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("calendar_management");

  cy.visit("/staff/conflict-resolution");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="conflictresolution-screen"]`).should("be.visible");
  cy.get(`[data-cy="conflictresolution-title"]`).should("be.visible");
  cy.get(`[data-cy="conflictresolution-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("conflict_resolution");

  cy.visit("/staff/open-shift");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="openshift-screen"]`).should("be.visible");
  cy.get(`[data-cy="openshift-title"]`).should("be.visible");
  cy.get(`[data-cy="openshift-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("open_shift");

  cy.visit("/staff/scheduling-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulingoperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulingoperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulingoperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduling_operations4_k");
  });

  it("tests org role customer_support", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.customer_support@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/customer-support-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_analytics");

  cy.visit("/common/customer-support-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_compliance");

  cy.visit("/common/customer-support-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_workflow");

  cy.visit("/common/support-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="supportanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_analytics");

  cy.visit("/common/support-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="supportcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_compliance");

  cy.visit("/common/support-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="supportworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_workflow");

  cy.visit("/staff/ticket-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ticketmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="ticketmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="ticketmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ticket_management");

  cy.visit("/staff/client-issue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clientissue-screen"]`).should("be.visible");
  cy.get(`[data-cy="clientissue-title"]`).should("be.visible");
  cy.get(`[data-cy="clientissue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("client_issue");

  cy.visit("/staff/communication");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communication-screen"]`).should("be.visible");
  cy.get(`[data-cy="communication-title"]`).should("be.visible");
  cy.get(`[data-cy="communication-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("communication");

  cy.visit("/staff/resolution-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="resolutiontracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="resolutiontracking-title"]`).should("be.visible");
  cy.get(`[data-cy="resolutiontracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("resolution_tracking");
  });

  it("tests org role training_coordinator", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.training_coordinator@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/staff/training-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="courseassignment-screen"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-title"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="certificationtracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-title"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffprogress-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-title"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_progress");
  });

  it("tests org role qa_specialist", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.qa_specialist@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/qa-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qaanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="qaanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="qaanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("qa_analytics");

  cy.visit("/common/qa-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qacompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="qacompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="qacompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("qa_compliance");

  cy.visit("/common/qa-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qaworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="qaworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="qaworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("qa_workflow");

  cy.visit("/staff/quality-assurance-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qualityassuranceanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="qualityassuranceanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="qualityassuranceanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("quality_assurance_analytics");

  cy.visit("/staff/quality-assurance-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qualityassurancecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="qualityassurancecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="qualityassurancecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("quality_assurance_compliance");

  cy.visit("/staff/quality-assurance-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qualityassuranceworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="qualityassuranceworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="qualityassuranceworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("quality_assurance_workflow");

  cy.visit("/staff/quality-audit");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qualityaudit-screen"]`).should("be.visible");
  cy.get(`[data-cy="qualityaudit-title"]`).should("be.visible");
  cy.get(`[data-cy="qualityaudit-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("quality_audit");

  cy.visit("/staff/failed-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="failedworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="failedworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="failedworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("failed_workflow");

  cy.visit("/staff/testing-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="testingoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="testingoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="testingoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("testing_overview");

  cy.visit("/staff/defect-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="defecttracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="defecttracking-title"]`).should("be.visible");
  cy.get(`[data-cy="defecttracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("defect_tracking");
  });

  it("tests org role family", () => {

function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.family@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}
    login();

  cy.visit("/common/family-member-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymemberanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymemberanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="familymemberanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_analytics");

  cy.visit("/common/family-member-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymembercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymembercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="familymembercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_compliance");

  cy.visit("/common/family-member-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymemberworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymemberworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="familymemberworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_workflow");

  cy.visit("/common/family-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familyoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="familyoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="familyoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_overview");

  cy.visit("/common/care-updates");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="careupdates-screen"]`).should("be.visible");
  cy.get(`[data-cy="careupdates-title"]`).should("be.visible");
  cy.get(`[data-cy="careupdates-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("care_updates");

  cy.visit("/common/billing-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="billingoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_overview");

  cy.visit("/common/emergency-contacts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="emergencycontacts-screen"]`).should("be.visible");
  cy.get(`[data-cy="emergencycontacts-title"]`).should("be.visible");
  cy.get(`[data-cy="emergencycontacts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("emergency_contacts");
  });

});
