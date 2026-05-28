// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_appointments", () => {
  it("opens and verifies screen franchise_owner_appointments", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/executive/franchise-owner-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");

  });
});
