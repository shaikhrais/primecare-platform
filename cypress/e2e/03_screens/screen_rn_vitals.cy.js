// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_vitals", () => {
  it("opens and verifies screen rn_vitals", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-vitals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnvitals-screen").should("be.visible");
  cy.getCy("rnvitals-title").should("be.visible");
  cy.getCy("rnvitals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_vitals");

  });
});
