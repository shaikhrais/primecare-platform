// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_medications", () => {
  it("opens and verifies screen rn_medications", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-medications");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnmedications-screen").should("be.visible");
  cy.getCy("rnmedications-title").should("be.visible");
  cy.getCy("rnmedications-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_medications");

  });
});
