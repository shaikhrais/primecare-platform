// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - physio", () => {
  it("tests all screens for role physio", () => {
    cy.loginAsRole("physio");


  cy.visitWithSemantics("/common/physiotherapist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  cy.getCy("physiotherapistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");

  cy.visitWithSemantics("/common/physiotherapist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistanalytics-screen").should("be.visible");
  cy.getCy("physiotherapistanalytics-title").should("be.visible");
  cy.getCy("physiotherapistanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_analytics");

  cy.visitWithSemantics("/common/physiotherapist-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");

  cy.visitWithSemantics("/common/physiotherapist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistworkflow-screen").should("be.visible");
  cy.getCy("physiotherapistworkflow-title").should("be.visible");
  cy.getCy("physiotherapistworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_workflow");

  cy.visitWithSemantics("/allied/physiotherapist-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_command_center");

  cy.visitWithSemantics("/allied/physiotherapist-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistappointments-screen").should("be.visible");
  cy.getCy("physiotherapistappointments-title").should("be.visible");
  cy.getCy("physiotherapistappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_appointments");

  cy.visitWithSemantics("/allied/physiotherapist-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistclientintake-screen").should("be.visible");
  cy.getCy("physiotherapistclientintake-title").should("be.visible");
  cy.getCy("physiotherapistclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_client_intake");

  cy.visitWithSemantics("/allied/physiotherapist-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistassessment-screen").should("be.visible");
  cy.getCy("physiotherapistassessment-title").should("be.visible");
  cy.getCy("physiotherapistassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_assessment");

  cy.visitWithSemantics("/allied/physiotherapist-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_treatment_notes");

  cy.visitWithSemantics("/allied/physiotherapist-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_exercise_plan");

  cy.visitWithSemantics("/allied/physiotherapist-billing-link");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
  cy.getCy("physiotherapistbillinglink-title").should("be.visible");
  cy.getCy("physiotherapistbillinglink-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_billing_link");

  cy.visitWithSemantics("/allied/physiotherapist-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistreports-screen").should("be.visible");
  cy.getCy("physiotherapistreports-title").should("be.visible");
  cy.getCy("physiotherapistreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_reports");

  cy.visitWithSemantics("/clinical/assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessment-screen").should("be.visible");
  cy.getCy("assessment-title").should("be.visible");
  cy.getCy("assessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("assessment");

  cy.visitWithSemantics("/clinical/treatment-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentplan-screen").should("be.visible");
  cy.getCy("treatmentplan-title").should("be.visible");
  cy.getCy("treatmentplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("treatment_plan");

  cy.visitWithSemantics("/clinical/exercise-prescription");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("exerciseprescription-screen").should("be.visible");
  cy.getCy("exerciseprescription-title").should("be.visible");
  cy.getCy("exerciseprescription-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("exercise_prescription");

  cy.visitWithSemantics("/clinical/progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("progresstracking-screen").should("be.visible");
  cy.getCy("progresstracking-title").should("be.visible");
  cy.getCy("progresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("progress_tracking");

  });
});
