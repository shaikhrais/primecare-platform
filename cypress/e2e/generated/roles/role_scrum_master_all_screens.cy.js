// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.scrum_master@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - scrum_master", () => {
  it("tests all screens for role scrum_master", () => {
    login();


  cy.visit("/management/scrum-master-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummasterdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_dashboard");

  cy.visit("/management/scrum-master-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummasteranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummasteranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummasteranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_analytics");

  cy.visit("/management/scrum-master-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummastercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummastercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummastercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_compliance");

  cy.visit("/management/scrum-master-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scrummasterworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="scrummasterworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scrum_master_workflow");

  });
});
