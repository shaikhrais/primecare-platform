// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.shareholder@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - shareholder", () => {
  it("tests all screens for role shareholder", () => {
    login();


  cy.visit("/executive/shareholder-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholderdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholderdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholderdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_dashboard");

  cy.visit("/executive/shareholder-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholderanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholderanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholderanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_analytics");

  cy.visit("/executive/shareholder-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholdercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholdercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholdercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_compliance");

  cy.visit("/executive/shareholder-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shareholderworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="shareholderworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="shareholderworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shareholder_workflow");

  });
});
