// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training", () => {
  it("tests all screens for role training", () => {
    cy.loginAsRole("training");


  cy.visit("/common/course-architect-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");

  cy.visit("/common/training-hub-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubdashboard-screen").should("be.visible");
  cy.getCy("traininghubdashboard-title").should("be.visible");
  cy.getCy("traininghubdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_dashboard");

  cy.visit("/executive/training-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");

  cy.visit("/staff/training-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");

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

  cy.visit("/common/training-hub-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubanalytics-screen").should("be.visible");
  cy.getCy("traininghubanalytics-title").should("be.visible");
  cy.getCy("traininghubanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_analytics");

  cy.visit("/common/training-hub-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubcompliance-screen").should("be.visible");
  cy.getCy("traininghubcompliance-title").should("be.visible");
  cy.getCy("traininghubcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_compliance");

  cy.visit("/common/training-hub-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubworkflow-screen").should("be.visible");
  cy.getCy("traininghubworkflow-title").should("be.visible");
  cy.getCy("traininghubworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_workflow");

  cy.visit("/executive/training-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectoranalytics-screen").should("be.visible");
  cy.getCy("trainingdirectoranalytics-title").should("be.visible");
  cy.getCy("trainingdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_analytics");

  cy.visit("/executive/training-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliance-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliance-title").should("be.visible");
  cy.getCy("trainingdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_compliance");

  cy.visit("/executive/training-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorworkflow-screen").should("be.visible");
  cy.getCy("trainingdirectorworkflow-title").should("be.visible");
  cy.getCy("trainingdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_workflow");

  cy.visit("/staff/training-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatoranalytics-screen").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-title").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_analytics");

  cy.visit("/staff/training-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcompliance-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-title").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_compliance");

  cy.visit("/staff/training-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorworkflow-screen").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-title").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_workflow");

  cy.visit("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_progress");

  });
});
