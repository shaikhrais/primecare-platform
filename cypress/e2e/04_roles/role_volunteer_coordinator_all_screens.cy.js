// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - volunteer_coordinator", () => {
  it("tests all screens for role volunteer_coordinator", () => {
    cy.loginAsRole("volunteer_coordinator");


  cy.visitWithSemantics("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");

  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
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
