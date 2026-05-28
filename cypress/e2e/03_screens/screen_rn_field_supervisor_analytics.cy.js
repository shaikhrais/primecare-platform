// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_field_supervisor_analytics", () => {
  it("opens and verifies screen rn_field_supervisor_analytics", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor analytics-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");

  });
});
