// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_field_supervisor_workflow", () => {
  it("opens and verifies screen rn_field_supervisor_workflow", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.visit("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor compliance workflow-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");

  });
});
