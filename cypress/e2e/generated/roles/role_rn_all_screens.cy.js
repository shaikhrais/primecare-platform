// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - rn", () => {
  it("tests all screens for role rn", () => {
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
});
