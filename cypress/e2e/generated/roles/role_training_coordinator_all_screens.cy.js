// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.training_coordinator@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - training_coordinator", () => {
  it("tests all screens for role training_coordinator", () => {
    login();


  cy.visit("/staff/training-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="courseassignment-screen"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-title"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="certificationtracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-title"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffprogress-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-title"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_progress");

  });
});
