// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_patient_charting", () => {
  it("opens and verifies screen rn_patient_charting", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnpatientcharting-screen").should("be.visible");
  cy.getCy("rnpatientcharting-title").should("be.visible");
  cy.getCy("rnpatientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_patient_charting");

  });
});
