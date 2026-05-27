// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.regional_bdm@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - regional_bdm", () => {
  it("tests all screens for role regional_bdm", () => {
    login();


  cy.visit("/management/regional-bdm-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_dashboard");

  cy.visit("/management/regional-bdm-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_analytics");

  cy.visit("/management/regional-bdm-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_compliance");

  cy.visit("/management/regional-bdm-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalbdmworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalbdmworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_bdm_workflow");

  });
});
