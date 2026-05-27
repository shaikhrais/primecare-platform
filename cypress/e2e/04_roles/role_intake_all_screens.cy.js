// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - intake", () => {
  it("tests all screens for role intake", () => {
    cy.loginAsRole("intake");


  cy.visit("/common/intake-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_dashboard");

  cy.visit("/staff/intake-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  cy.getCy("intakecoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");

  cy.visit("/common/intake-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeanalytics-screen").should("be.visible");
  cy.getCy("intakeanalytics-title").should("be.visible");
  cy.getCy("intakeanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_analytics");

  cy.visit("/common/intake-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecompliance-screen").should("be.visible");
  cy.getCy("intakecompliance-title").should("be.visible");
  cy.getCy("intakecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_compliance");

  cy.visit("/common/intake-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeworkflow-screen").should("be.visible");
  cy.getCy("intakeworkflow-title").should("be.visible");
  cy.getCy("intakeworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_workflow");

  cy.visit("/staff/intake-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatoranalytics-screen").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-title").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_analytics");

  cy.visit("/staff/intake-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");

  cy.visit("/staff/intake-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorworkflow-screen").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-title").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_workflow");

  cy.visit("/executive/referral-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("referralmanagement-screen").should("be.visible");
  cy.getCy("referralmanagement-title").should("be.visible");
  cy.getCy("referralmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("referral_management");

  cy.visit("/executive/client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientintake-screen").should("be.visible");
  cy.getCy("clientintake-title").should("be.visible");
  cy.getCy("clientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_intake");

  cy.visit("/executive/booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("booking-screen").should("be.visible");
  cy.getCy("booking-title").should("be.visible");
  cy.getCy("booking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("booking");

  cy.visit("/executive/followup");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("followup-screen").should("be.visible");
  cy.getCy("followup-title").should("be.visible");
  cy.getCy("followup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("followup");

  });
});
