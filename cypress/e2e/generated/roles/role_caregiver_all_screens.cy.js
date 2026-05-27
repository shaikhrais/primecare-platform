// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.caregiver@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - caregiver", () => {
  it("tests all screens for role caregiver", () => {
    login();


  cy.visit("/common/caregiver-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_dashboard");

  cy.visit("/psw/caregiver-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregivertasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregivertasks-title"]`).should("be.visible");
  cy.get(`[data-cy="caregivertasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_tasks");

  cy.visit("/psw/caregiver-client-profile");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverclientprofile-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverclientprofile-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverclientprofile-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_client_profile");

  cy.visit("/psw/caregiver-visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregivervisitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregivervisitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="caregivervisitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_visit_notes");

  cy.visit("/psw/caregiver-schedule");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverschedule-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverschedule-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverschedule-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_schedule");

  cy.visit("/psw/caregiver-incident-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="caregiverincidentreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="caregiverincidentreport-title"]`).should("be.visible");
  cy.get(`[data-cy="caregiverincidentreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("caregiver_incident_report");

  cy.visit("/psw/schedule");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedule-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedule-title"]`).should("be.visible");
  cy.get(`[data-cy="schedule-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("schedule");

  cy.visit("/psw/messaging");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="messaging-screen"]`).should("be.visible");
  cy.get(`[data-cy="messaging-title"]`).should("be.visible");
  cy.get(`[data-cy="messaging-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("messaging");

  });
});
