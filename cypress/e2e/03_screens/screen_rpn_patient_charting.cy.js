// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_patient_charting", () => {
  it("opens and verifies screen rpn_patient_charting", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnpatientcharting-screen").should("be.visible");
  cy.getCy("rpnpatientcharting-title").should("be.visible");
  cy.getCy("rpnpatientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_patient_charting");

  });
});
