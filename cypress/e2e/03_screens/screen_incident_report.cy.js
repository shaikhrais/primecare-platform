// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_report", () => {
  it("opens and verifies screen incident_report", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreport-screen").should("be.visible");
  cy.getCy("incidentreport-title").should("be.visible");
  cy.getCy("incidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_report");

  });
});
