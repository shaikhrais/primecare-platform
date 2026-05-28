// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - certification_tracking", () => {
  it("opens and verifies screen certification_tracking", () => {
    cy.loginAsRole("training_coordinator");

  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  });
});
