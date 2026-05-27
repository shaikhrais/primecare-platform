// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_incident_reports", () => {
  it("opens and verifies screen hsw_incident_reports", () => {
    cy.loginAsRole("hsw");

  cy.visit("/clinical/hsw-incident-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswincidentreports-screen").should("be.visible");
  cy.getCy("hswincidentreports-title").should("be.visible");
  cy.getCy("hswincidentreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_incident_reports");

  });
});
