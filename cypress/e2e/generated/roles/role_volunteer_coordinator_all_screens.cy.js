// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.volunteer_coordinator@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - volunteer_coordinator", () => {
  it("tests all screens for role volunteer_coordinator", () => {
    login();


  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorreferrals-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatornewclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorassessmentqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorbooking-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorfollowup-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_follow_up");

  });
});
