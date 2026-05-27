// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.intake@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - intake", () => {
  it("tests all screens for role intake", () => {
    login();


  cy.visit("/common/intake-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="intakedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_dashboard");

  cy.visit("/staff/intake-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_dashboard");

  cy.visit("/common/intake-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakeanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakeanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="intakeanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_analytics");

  cy.visit("/common/intake-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_compliance");

  cy.visit("/common/intake-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakeworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakeworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="intakeworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_workflow");

  cy.visit("/staff/intake-coordinator-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_analytics");

  cy.visit("/staff/intake-coordinator-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_compliance");

  cy.visit("/staff/intake-coordinator-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_workflow");

  cy.visit("/executive/referral-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="referralmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="referralmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="referralmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("referral_management");

  cy.visit("/executive/client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="clientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="clientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("client_intake");

  cy.visit("/executive/booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="booking-screen"]`).should("be.visible");
  cy.get(`[data-cy="booking-title"]`).should("be.visible");
  cy.get(`[data-cy="booking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("booking");

  cy.visit("/executive/followup");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="followup-screen"]`).should("be.visible");
  cy.get(`[data-cy="followup-title"]`).should("be.visible");
  cy.get(`[data-cy="followup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("followup");

  });
});
