// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_oversight", () => {
  it("opens and verifies screen incident_oversight", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/incident-oversight");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_oversight");

  });
});
