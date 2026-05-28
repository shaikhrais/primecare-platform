// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_management", () => {
  it("opens and verifies screen incident_management", () => {
    cy.loginAsRole("compliance");

  cy.visitWithSemantics("/management/incident-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentmanagement-screen").should("be.visible");
  cy.getCy("incidentmanagement-title").should("be.visible");
  cy.getCy("incidentmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_management");

  });
});
