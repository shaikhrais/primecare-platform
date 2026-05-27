// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - chiropractor", () => {
  it("tests all screens for role chiropractor", () => {
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
});
