// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.np@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - np", () => {
  it("tests all screens for role np", () => {
    login();


  cy.visit("/clinical/np-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="npdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="npdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="npdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("np_dashboard");

  cy.visit("/rn/np-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="nurse practitioner (np) analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("np_analytics");

  cy.visit("/rn/np-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="nurse practitioner (np) compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="nurse practitioner (np) compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("np_workflow");

  });
});
