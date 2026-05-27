// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - volunteer", () => {
  it("tests all screens for role volunteer", () => {
    cy.loginAsRole("volunteer");


  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/staff/volunteer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");

  cy.visit("/staff/volunteer-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatoranalytics-screen").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-title").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_analytics");

  cy.visit("/staff/volunteer-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorcompliance-screen").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-title").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_compliance");

  cy.visit("/staff/volunteer-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorworkflow-screen").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-title").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_workflow");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");

  });
});
