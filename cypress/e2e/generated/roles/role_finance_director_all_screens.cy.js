// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.finance_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - finance_director", () => {
  it("tests all screens for role finance_director", () => {
    login();


  cy.visit("/executive/finance-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_dashboard");

  cy.visit("/executive/finance-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_analytics");

  cy.visit("/executive/finance-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_compliance");

  cy.visit("/executive/finance-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="financedirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="financedirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("finance_director_workflow");

  });
});
