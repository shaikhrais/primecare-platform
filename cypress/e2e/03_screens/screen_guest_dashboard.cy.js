// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_dashboard", () => {
  it("opens and verifies screen guest_dashboard", () => {
    cy.loginAsRole("guest");

  cy.visitWithSemantics("/common/guest-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestdashboard-screen").should("be.visible");
  cy.getCy("guestdashboard-title").should("be.visible");
  cy.getCy("guestdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_dashboard");

  });
});
