// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.training@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - training", () => {
  it("tests all screens for role training", () => {
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

  cy.visit("/common/training-hub-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_dashboard");

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

  cy.visit("/staff/training-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_dashboard");

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

  cy.visit("/common/training-hub-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_analytics");

  cy.visit("/common/training-hub-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_compliance");

  cy.visit("/common/training-hub-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="traininghubworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="traininghubworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="traininghubworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_hub_workflow");

  cy.visit("/executive/training-director-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_analytics");

  cy.visit("/executive/training-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_compliance");

  cy.visit("/executive/training-director-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdirectorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdirectorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_director_workflow");

  cy.visit("/staff/training-coordinator-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatoranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatoranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatoranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_analytics");

  cy.visit("/staff/training-coordinator-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_compliance");

  cy.visit("/staff/training-coordinator-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingcoordinatorworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingcoordinatorworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_coordinator_workflow");

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
