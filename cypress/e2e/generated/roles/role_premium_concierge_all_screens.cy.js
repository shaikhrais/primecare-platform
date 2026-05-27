// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.premium_concierge@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - premium_concierge", () => {
  it("tests all screens for role premium_concierge", () => {
    login();


  cy.visit("/management/premium-concierge-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="premiumconciergedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="premiumconciergedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="premiumconciergedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("premium_concierge_dashboard");

  cy.visit("/premium/premium-concierge-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="premium concierge care coordinator analytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator analytics-title"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator analytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("premium_concierge_analytics");

  cy.visit("/premium/premium-concierge-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="premium concierge care coordinator compliance workflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator compliance workflow-title"]`).should("be.visible");
  cy.get(`[data-cy="premium concierge care coordinator compliance workflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("premium_concierge_workflow");

  });
});
