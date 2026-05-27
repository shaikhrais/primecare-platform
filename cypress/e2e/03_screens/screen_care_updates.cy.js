// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - care_updates", () => {
  it("opens and verifies screen care_updates", () => {
    cy.loginAsRole("family");

  cy.visit("/common/care-updates");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_updates");

  });
});
