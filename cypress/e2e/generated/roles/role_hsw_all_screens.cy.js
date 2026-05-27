// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.hsw@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - hsw", () => {
  it("tests all screens for role hsw", () => {
    login();


  cy.visit("/clinical/hsw-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="hswdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_dashboard");

  cy.visit("/clinical/hsw-adl-logger");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswadllogger-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswadllogger-title"]`).should("be.visible");
  cy.get(`[data-cy="hswadllogger-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_adl_logger");

  cy.visit("/clinical/hsw-care-plans");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswcareplans-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswcareplans-title"]`).should("be.visible");
  cy.get(`[data-cy="hswcareplans-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_care_plans");

  cy.visit("/clinical/hsw-incident-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswincidentreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswincidentreports-title"]`).should("be.visible");
  cy.get(`[data-cy="hswincidentreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_incident_reports");

  cy.visit("/clinical/hsw-schedule");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hswschedule-screen"]`).should("be.visible");
  cy.get(`[data-cy="hswschedule-title"]`).should("be.visible");
  cy.get(`[data-cy="hswschedule-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hsw_schedule");

  });
});
