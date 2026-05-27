// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.franchise_sales@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - franchise_sales", () => {
  it("tests all screens for role franchise_sales", () => {
    login();


  cy.visit("/management/franchise-sales-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchisesalesmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="franchisesalesmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_manager_dashboard");

  cy.visit("/executive/franchise-sales-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchise sales manager analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_analytics");

  cy.visit("/executive/franchise-sales-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchise sales manager compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="franchise sales manager compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_sales_workflow");

  });
});
