// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - physio", () => {
  it("tests all screens for role physio", () => {
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
});
