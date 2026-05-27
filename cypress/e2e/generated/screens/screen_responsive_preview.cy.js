// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - responsive_preview", () => {
  it("opens and verifies screen responsive_preview", () => {
    cy.loginAsRole("governance");

  cy.visit("/common/responsive-preview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("responsive_preview");

  });
});
