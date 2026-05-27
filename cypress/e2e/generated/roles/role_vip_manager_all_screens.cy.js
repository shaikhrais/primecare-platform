// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.vip_manager@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - vip_manager", () => {
  it("tests all screens for role vip_manager", () => {
    login();


  cy.visit("/management/vip-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vipmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="vipmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="vipmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vip_manager_dashboard");

  cy.visit("/executive/vip-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vip client manager analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vip_manager_analytics");

  cy.visit("/executive/vip-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vip client manager compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="vip client manager compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vip_manager_workflow");

  });
});
