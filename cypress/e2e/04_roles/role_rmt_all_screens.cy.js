// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rmt", () => {
  it("tests all screens for role rmt", () => {
    cy.loginAsRole("rmt");


  cy.visitWithSemantics("/allied/rmt-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtdashboard-screen").should("be.visible");
  cy.getCy("rmtdashboard-title").should("be.visible");
  cy.getCy("rmtdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_dashboard");

  cy.visitWithSemantics("/allied/rmt-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtanalytics-screen").should("be.visible");
  cy.getCy("rmtanalytics-title").should("be.visible");
  cy.getCy("rmtanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_analytics");

  cy.visitWithSemantics("/allied/rmt-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcompliance-screen").should("be.visible");
  cy.getCy("rmtcompliance-title").should("be.visible");
  cy.getCy("rmtcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_compliance");

  cy.visitWithSemantics("/allied/rmt-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtworkflow-screen").should("be.visible");
  cy.getCy("rmtworkflow-title").should("be.visible");
  cy.getCy("rmtworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_workflow");

  cy.visitWithSemantics("/allied/rmt-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcommandcenter-screen").should("be.visible");
  cy.getCy("rmtcommandcenter-title").should("be.visible");
  cy.getCy("rmtcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_command_center");

  cy.visitWithSemantics("/allied/rmt-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtappointments-screen").should("be.visible");
  cy.getCy("rmtappointments-title").should("be.visible");
  cy.getCy("rmtappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_appointments");

  cy.visitWithSemantics("/allied/rmt-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtclientintake-screen").should("be.visible");
  cy.getCy("rmtclientintake-title").should("be.visible");
  cy.getCy("rmtclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_client_intake");

  cy.visitWithSemantics("/allied/rmt-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtassessment-screen").should("be.visible");
  cy.getCy("rmtassessment-title").should("be.visible");
  cy.getCy("rmtassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_assessment");

  cy.visitWithSemantics("/allied/rmt-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmttreatmentnotes-screen").should("be.visible");
  cy.getCy("rmttreatmentnotes-title").should("be.visible");
  cy.getCy("rmttreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_treatment_notes");

  cy.visitWithSemantics("/allied/rmt-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtexerciseplan-screen").should("be.visible");
  cy.getCy("rmtexerciseplan-title").should("be.visible");
  cy.getCy("rmtexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_exercise_plan");

  cy.visitWithSemantics("/allied/rmt-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtbillinglink-screen").should("be.visible");
  cy.getCy("rmtbillinglink-title").should("be.visible");
  cy.getCy("rmtbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_billing_link");

  cy.visitWithSemantics("/allied/rmt-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtreports-screen").should("be.visible");
  cy.getCy("rmtreports-title").should("be.visible");
  cy.getCy("rmtreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_reports");

  cy.visitWithSemantics("/allied/massage-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("massageassessment-screen").should("be.visible");
  cy.getCy("massageassessment-title").should("be.visible");
  cy.getCy("massageassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("massage_assessment");

  cy.visitWithSemantics("/allied/treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentnotes-screen").should("be.visible");
  cy.getCy("treatmentnotes-title").should("be.visible");
  cy.getCy("treatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("treatment_notes");

  cy.visitWithSemantics("/allied/home-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("homecareplan-screen").should("be.visible");
  cy.getCy("homecareplan-title").should("be.visible");
  cy.getCy("homecareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("home_care_plan");

  cy.visitWithSemantics("/allied/client-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientprogress-screen").should("be.visible");
  cy.getCy("clientprogress-title").should("be.visible");
  cy.getCy("clientprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_progress");

  });
});
