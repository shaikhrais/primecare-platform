// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_interviews", () => {
  it("opens and verifies screen hr_hiring_interviews", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-interviews");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringinterviews-screen").should("be.visible");
  cy.getCy("hrhiringinterviews-title").should("be.visible");
  cy.getCy("hrhiringinterviews-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_interviews");

  });
});
