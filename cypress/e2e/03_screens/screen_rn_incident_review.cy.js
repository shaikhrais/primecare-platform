// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_incident_review", () => {
  it("opens and verifies screen rn_incident_review", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/rn-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnincidentreview-screen").should("be.visible");
  cy.getCy("rnincidentreview-title").should("be.visible");
  cy.getCy("rnincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_incident_review");

  });
});
