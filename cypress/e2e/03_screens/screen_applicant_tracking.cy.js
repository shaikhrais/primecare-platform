// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - applicant_tracking", () => {
  it("opens and verifies screen applicant_tracking", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/applicant-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("applicanttracking-screen").should("be.visible");
  cy.getCy("applicanttracking-title").should("be.visible");
  cy.getCy("applicanttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("applicant_tracking");

  });
});
