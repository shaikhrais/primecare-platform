// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.social_worker@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - social_worker", () => {
  it("tests all screens for role social_worker", () => {
    login();


  cy.visit("/common/social-worker-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_dashboard");

  cy.visit("/common/social-worker-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkeranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkeranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkeranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_analytics");

  cy.visit("/common/social-worker-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_compliance");

  cy.visit("/common/social-worker-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialworkerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="socialworkerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_worker_workflow");

  });
});
