// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.guest@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - guest", () => {
  it("tests all screens for role guest", () => {
    login();


  cy.visit("/common/dynamic-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamicdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamicdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamicdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_screen_dashboard");

  cy.visit("/common/guest-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="guestdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_dashboard");

  cy.visit("/common/guest-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="guestanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_analytics");

  cy.visit("/common/guest-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="guestcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_compliance");

  cy.visit("/common/guest-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="guestworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="guestworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="guestworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("guest_workflow");

  });
});
