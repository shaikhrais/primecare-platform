// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training_director", () => {
  it("tests all screens for role training_director", () => {
    cy.loginAsRole("training_director");


  cy.visit("/common/course-architect-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");

  cy.visit("/executive/training-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");

  cy.visit("/common/course-architect-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");

  cy.visit("/common/course-architect-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");

  cy.visit("/common/course-architect-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");

  });
});
