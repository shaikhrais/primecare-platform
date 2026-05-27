// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - qa_specialist", () => {
  it("tests all screens for role qa_specialist", () => {
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
});
