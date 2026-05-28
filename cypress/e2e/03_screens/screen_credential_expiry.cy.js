// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - credential_expiry", () => {
  it("opens and verifies screen credential_expiry", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/management/credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("credential_expiry");

  });
});
