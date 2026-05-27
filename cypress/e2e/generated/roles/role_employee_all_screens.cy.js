// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - employee", () => {
  it("tests all screens for role employee", () => {
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
});
