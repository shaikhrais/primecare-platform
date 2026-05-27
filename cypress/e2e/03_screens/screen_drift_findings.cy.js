// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - drift_findings", () => {
  it("opens and verifies screen drift_findings", () => {
    cy.loginAsRole("governance");

  cy.visit("/common/drift-findings");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("drift_findings");

  });
});
