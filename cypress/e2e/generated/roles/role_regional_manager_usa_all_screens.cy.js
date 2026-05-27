// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.regional_manager_usa@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - regional_manager_usa", () => {
  it("tests all screens for role regional_manager_usa", () => {
    login();


  cy.visit("/management/regional-manager-usa-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusadashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusadashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusadashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_dashboard");

  cy.visit("/management/regional-manager-usa-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusaanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_analytics");

  cy.visit("/management/regional-manager-usa-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusacompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusacompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusacompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_compliance");

  cy.visit("/management/regional-manager-usa-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="regionalmanagerusaworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="regionalmanagerusaworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("regional_manager_usa_workflow");

  });
});
