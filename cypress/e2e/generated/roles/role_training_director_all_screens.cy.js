// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.training_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - training_director", () => {
  it("tests all screens for role training_director", () => {
    login();


  cy.visit("/common/course-architect-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_dashboard");

  cy.visit("/executive/training-director-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_dashboard");

  cy.visit("/common/course-architect-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_analytics");

  cy.visit("/common/course-architect-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_compliance");

  cy.visit("/common/course-architect-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coursearchitectworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="coursearchitectworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_architect_workflow");

  });
});
