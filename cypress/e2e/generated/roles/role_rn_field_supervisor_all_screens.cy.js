// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


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

describe("Role All Screens - rn_field_supervisor", () => {
  it("tests all screens for role rn_field_supervisor", () => {
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
});
