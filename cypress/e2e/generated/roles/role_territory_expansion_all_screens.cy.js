// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.territory_expansion@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - territory_expansion", () => {
  it("tests all screens for role territory_expansion", () => {
    login();


  cy.visit("/management/territory-expansion-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_dashboard");

  cy.visit("/management/territory-expansion-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_analytics");

  cy.visit("/management/territory-expansion-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_compliance");

  cy.visit("/management/territory-expansion-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territoryexpansionmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="territoryexpansionmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_expansion_manager_workflow");

  });
});
