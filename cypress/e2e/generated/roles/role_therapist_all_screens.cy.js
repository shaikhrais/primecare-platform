// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.therapist@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - therapist", () => {
  it("tests all screens for role therapist", () => {
    login();


  cy.visit("/allied/therapist-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="therapistdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="therapistdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="therapistdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("therapist_dashboard");

  cy.visit("/allied/therapist-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="therapist analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="therapist analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="therapist analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("therapist_analytics");

  cy.visit("/allied/therapist-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="therapist compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="therapist compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="therapist compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("therapist_workflow");

  });
});
