// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_charting", () => {
  it("opens and verifies screen patient_charting", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcharting-screen").should("be.visible");
  cy.getCy("patientcharting-title").should("be.visible");
  cy.getCy("patientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_charting");

  });
});
