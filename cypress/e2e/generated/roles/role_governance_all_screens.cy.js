// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - governance", () => {
  it("tests all screens for role governance", () => {
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
});
