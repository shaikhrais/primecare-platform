// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_applicants", () => {
  it("opens and verifies screen hr_hiring_applicants", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-applicants");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringapplicants-screen").should("be.visible");
  cy.getCy("hrhiringapplicants-title").should("be.visible");
  cy.getCy("hrhiringapplicants-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_applicants");

  });
});
