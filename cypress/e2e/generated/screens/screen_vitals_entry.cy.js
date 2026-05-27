// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vitals_entry", () => {
  it("opens and verifies screen vitals_entry", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/vitals-entry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vitals_entry");

  });
});
