// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.cx_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - cx_director", () => {
  it("tests all screens for role cx_director", () => {
    login();


  cy.visit("/executive/cx-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_dashboard");

  cy.visit("/executive/cx-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_analytics");

  cy.visit("/executive/cx-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_compliance");

  cy.visit("/executive/cx-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cxdirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cxdirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("cx_director_workflow");

  });
});
