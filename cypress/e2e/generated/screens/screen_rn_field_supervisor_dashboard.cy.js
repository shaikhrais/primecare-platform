// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_field_supervisor_dashboard", () => {
  it("opens and verifies screen rn_field_supervisor_dashboard", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.visit("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");

  });
});
