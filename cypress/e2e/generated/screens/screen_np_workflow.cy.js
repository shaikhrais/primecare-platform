// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - np_workflow", () => {
  it("opens and verifies screen np_workflow", () => {
    cy.loginAsRole("np");

  cy.visit("/rn/np-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nurse practitioner (np) compliance workflow-screen").should("be.visible");
  cy.getCy("nurse practitioner (np) compliance workflow-title").should("be.visible");
  cy.getCy("nurse practitioner (np) compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_workflow");

  });
});
