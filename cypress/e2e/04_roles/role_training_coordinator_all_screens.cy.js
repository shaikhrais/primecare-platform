// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - training_coordinator", () => {
  it("tests all screens for role training_coordinator", () => {
    cy.loginAsRole("training_coordinator");


  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  cy.visitWithSemantics("/staff/staff-progress");
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
