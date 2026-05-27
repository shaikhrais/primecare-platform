// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rpn", () => {
  it("tests all screens for role rpn", () => {
    cy.loginAsRole("rpn");


  cy.visit("/rpn/rpn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpndashboard-screen").should("be.visible");
  cy.getCy("rpndashboard-title").should("be.visible");
  cy.getCy("rpndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");

  cy.visit("/rpn/rpn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnanalytics-screen").should("be.visible");
  cy.getCy("rpnanalytics-title").should("be.visible");
  cy.getCy("rpnanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_analytics");

  cy.visit("/rpn/rpn-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncompliance-screen").should("be.visible");
  cy.getCy("rpncompliance-title").should("be.visible");
  cy.getCy("rpncompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_compliance");

  cy.visit("/rpn/rpn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnworkflow-screen").should("be.visible");
  cy.getCy("rpnworkflow-title").should("be.visible");
  cy.getCy("rpnworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_workflow");

  cy.visit("/rpn/rpn-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncommandcenter-screen").should("be.visible");
  cy.getCy("rpncommandcenter-title").should("be.visible");
  cy.getCy("rpncommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_command_center");

  cy.visit("/rpn/rpn-patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnpatientcharting-screen").should("be.visible");
  cy.getCy("rpnpatientcharting-title").should("be.visible");
  cy.getCy("rpnpatientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_patient_charting");

  cy.visit("/rpn/rpn-medications");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnmedications-screen").should("be.visible");
  cy.getCy("rpnmedications-title").should("be.visible");
  cy.getCy("rpnmedications-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_medications");

  cy.visit("/rpn/rpn-vitals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnvitals-screen").should("be.visible");
  cy.getCy("rpnvitals-title").should("be.visible");
  cy.getCy("rpnvitals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_vitals");

  cy.visit("/rpn/rpn-care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncareplanreview-screen").should("be.visible");
  cy.getCy("rpncareplanreview-title").should("be.visible");
  cy.getCy("rpncareplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_care_plan_review");

  cy.visit("/rpn/rpn-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnincidentreview-screen").should("be.visible");
  cy.getCy("rpnincidentreview-title").should("be.visible");
  cy.getCy("rpnincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_incident_review");

  cy.visit("/rpn/rpn-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpntasks-screen").should("be.visible");
  cy.getCy("rpntasks-title").should("be.visible");
  cy.getCy("rpntasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_tasks");

  cy.visit("/rpn/rpn-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnreports-screen").should("be.visible");
  cy.getCy("rpnreports-title").should("be.visible");
  cy.getCy("rpnreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_reports");

  cy.visit("/clinical/nursing-task");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nursingtask-screen").should("be.visible");
  cy.getCy("nursingtask-title").should("be.visible");
  cy.getCy("nursingtask-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("nursing_task");

  cy.visit("/clinical/vitals-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalstracking-screen").should("be.visible");
  cy.getCy("vitalstracking-title").should("be.visible");
  cy.getCy("vitalstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vitals_tracking");

  cy.visit("/clinical/medication");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medication-screen").should("be.visible");
  cy.getCy("medication-title").should("be.visible");
  cy.getCy("medication-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("medication");

  cy.visit("/clinical/patient-observation");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientobservation-screen").should("be.visible");
  cy.getCy("patientobservation-title").should("be.visible");
  cy.getCy("patientobservation-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_observation");

  });
});
