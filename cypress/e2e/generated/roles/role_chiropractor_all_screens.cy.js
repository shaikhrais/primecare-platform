// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - chiropractor", () => {
  it("tests all screens for role chiropractor", () => {
    cy.loginAsRole("chiropractor");


  cy.visit("/common/chiropractor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");

  cy.visit("/common/chiropractor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");

  cy.visit("/common/chiropractor-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");

  cy.visit("/common/chiropractor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");

  cy.visit("/allied/chiropractor-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");

  cy.visit("/allied/chiropractor-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");

  cy.visit("/allied/chiropractor-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");

  cy.visit("/allied/chiropractor-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorassessment-screen").should("be.visible");
  cy.getCy("chiropractorassessment-title").should("be.visible");
  cy.getCy("chiropractorassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_assessment");

  cy.visit("/allied/chiropractor-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");

  cy.visit("/allied/chiropractor-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");

  cy.visit("/allied/chiropractor-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");

  cy.visit("/allied/chiropractor-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");

  cy.visit("/allied/chiropractic-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");

  cy.visit("/allied/adjustment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("adjustment_notes");

  cy.visit("/allied/xray-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("xray_review");

  cy.visit("/allied/chiropractic-progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");

  });
});
