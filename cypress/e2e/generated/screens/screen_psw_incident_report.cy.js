// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_incident_report", () => {
  it("opens and verifies screen psw_incident_report", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswincidentreport-screen").should("be.visible");
  cy.getCy("pswincidentreport-title").should("be.visible");
  cy.getCy("pswincidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_incident_report");

  });
});
