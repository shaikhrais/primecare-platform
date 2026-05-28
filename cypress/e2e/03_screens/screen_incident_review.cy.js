// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_review", () => {
  it("opens and verifies screen incident_review", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreview-screen").should("be.visible");
  cy.getCy("incidentreview-title").should("be.visible");
  cy.getCy("incidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_review");

  });
});
