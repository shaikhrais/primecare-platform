// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_assessments", () => {
  it("opens and verifies screen rn_assessments", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/rn-assessments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnassessments-screen").should("be.visible");
  cy.getCy("rnassessments-title").should("be.visible");
  cy.getCy("rnassessments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_assessments");

  });
});
