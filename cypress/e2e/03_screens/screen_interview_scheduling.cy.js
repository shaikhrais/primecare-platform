// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - interview_scheduling", () => {
  it("opens and verifies screen interview_scheduling", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/interview-scheduling");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("interviewscheduling-screen").should("be.visible");
  cy.getCy("interviewscheduling-title").should("be.visible");
  cy.getCy("interviewscheduling-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("interview_scheduling");

  });
});
