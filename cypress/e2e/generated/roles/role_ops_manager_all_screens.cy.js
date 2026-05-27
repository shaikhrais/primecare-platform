// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - ops_manager", () => {
  it("tests all screens for role ops_manager", () => {
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
});
