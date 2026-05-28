// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_credential_expiry", () => {
  it("opens and verifies screen hr_director_credential_expiry", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");

  });
});
