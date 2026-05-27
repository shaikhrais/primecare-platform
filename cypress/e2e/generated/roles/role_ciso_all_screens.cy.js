// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.ciso@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - ciso", () => {
  it("tests all screens for role ciso", () => {
    login();


  cy.visit("/executive/ciso-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisodashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisodashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="cisodashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_dashboard");

  cy.visit("/executive/ciso-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisoanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisoanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cisoanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_analytics");

  cy.visit("/executive/ciso-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisocompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisocompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cisocompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_compliance");

  cy.visit("/executive/ciso-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cisoworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cisoworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cisoworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ciso_workflow");

  });
});
