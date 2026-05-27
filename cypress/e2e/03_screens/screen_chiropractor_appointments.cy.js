// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_appointments", () => {
  it("opens and verifies screen chiropractor_appointments", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/allied/chiropractor-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");

  });
});
