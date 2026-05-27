// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.cns@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - cns", () => {
  it("tests all screens for role cns", () => {
    login();


  cy.visit("/clinical/cns-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cnsdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cnsdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cnsdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cns_dashboard");

  cy.visit("/rn/cns-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinical nurse specialist analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cns_analytics");

  cy.visit("/rn/cns-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinical nurse specialist compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="clinical nurse specialist compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cns_workflow");

  });
});
