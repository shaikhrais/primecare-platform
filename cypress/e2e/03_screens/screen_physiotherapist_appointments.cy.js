// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_appointments", () => {
  it("opens and verifies screen physiotherapist_appointments", () => {
    cy.loginAsRole("physio");

  cy.visit("/allied/physiotherapist-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistappointments-screen").should("be.visible");
  cy.getCy("physiotherapistappointments-title").should("be.visible");
  cy.getCy("physiotherapistappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_appointments");

  });
});
