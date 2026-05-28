// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_analytics", () => {
  it("opens and verifies screen guest_analytics", () => {
    cy.loginAsRole("guest");

  cy.visitWithSemantics("/common/guest-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestanalytics-screen").should("be.visible");
  cy.getCy("guestanalytics-title").should("be.visible");
  cy.getCy("guestanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_analytics");

  });
});
