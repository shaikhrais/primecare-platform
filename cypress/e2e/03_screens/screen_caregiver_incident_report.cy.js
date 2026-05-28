// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_incident_report", () => {
  it("opens and verifies screen caregiver_incident_report", () => {
    cy.loginAsRole("caregiver");

  cy.visitWithSemantics("/psw/caregiver-incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverincidentreport-screen").should("be.visible");
  cy.getCy("caregiverincidentreport-title").should("be.visible");
  cy.getCy("caregiverincidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_incident_report");

  });
});
