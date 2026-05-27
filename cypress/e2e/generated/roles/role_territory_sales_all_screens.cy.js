// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.territory_sales@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - territory_sales", () => {
  it("tests all screens for role territory_sales", () => {
    login();


  cy.visit("/management/territory-sales-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_dashboard");

  cy.visit("/management/territory-sales-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_analytics");

  cy.visit("/management/territory-sales-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_compliance");

  cy.visit("/management/territory-sales-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="territorysalesmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="territorysalesmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("territory_sales_manager_workflow");

  });
});
