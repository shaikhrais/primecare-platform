// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.portal@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - portal", () => {
  it("tests all screens for role portal", () => {
    login();


  cy.visit("/common/portal-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portaldashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="portaldashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="portaldashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_dashboard");

  cy.visit("/common/portal-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portalanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="portalanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="portalanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_analytics");

  cy.visit("/common/portal-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portalcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="portalcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="portalcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_compliance");

  cy.visit("/common/portal-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="portalworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="portalworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="portalworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("portal_workflow");

  });
});
