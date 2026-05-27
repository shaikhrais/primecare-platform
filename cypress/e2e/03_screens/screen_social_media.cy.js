// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_media", () => {
  it("opens and verifies screen social_media", () => {
    cy.loginAsRole("marketing");

  cy.visit("/management/social-media");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmedia-screen").should("be.visible");
  cy.getCy("socialmedia-title").should("be.visible");
  cy.getCy("socialmedia-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_media");

  });
});
