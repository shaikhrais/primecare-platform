// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_appointments", () => {
  it("opens and verifies screen rmt_appointments", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtappointments-screen").should("be.visible");
  cy.getCy("rmtappointments-title").should("be.visible");
  cy.getCy("rmtappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_appointments");

  });
});
