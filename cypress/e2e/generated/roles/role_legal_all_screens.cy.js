// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.legal@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - legal", () => {
  it("tests all screens for role legal", () => {
    login();


  cy.visit("/executive/legal-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legaldashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="legaldashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="legaldashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_dashboard");

  cy.visit("/executive/legal-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legalanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="legalanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="legalanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_analytics");

  cy.visit("/executive/legal-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legalcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="legalcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="legalcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_compliance");

  cy.visit("/executive/legal-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="legalworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="legalworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="legalworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("legal_workflow");

  });
});
