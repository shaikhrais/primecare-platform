// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_compliance", () => {
  it("opens and verifies screen guest_compliance", () => {
    cy.loginAsRole("guest");

  cy.visit("/common/guest-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestcompliance-screen").should("be.visible");
  cy.getCy("guestcompliance-title").should("be.visible");
  cy.getCy("guestcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_compliance");

  });
});
