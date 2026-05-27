// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - rmt", () => {
  it("tests all screens for role rmt", () => {
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
});
