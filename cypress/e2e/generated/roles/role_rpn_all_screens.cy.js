// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - rpn", () => {
  it("tests all screens for role rpn", () => {
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
});
