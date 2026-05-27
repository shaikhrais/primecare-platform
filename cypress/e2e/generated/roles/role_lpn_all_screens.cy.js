// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.lpn@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - lpn", () => {
  it("tests all screens for role lpn", () => {
    login();


  cy.visit("/clinical/lpn-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="lpndashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="lpndashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="lpndashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lpn_dashboard");

  cy.visit("/rpn/lpn-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="licensed practical nurse (lpn) analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lpn_analytics");

  cy.visit("/rpn/lpn-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="licensed practical nurse (lpn) compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="licensed practical nurse (lpn) compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lpn_workflow");

  });
});
