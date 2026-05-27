// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vitals_tracking", () => {
  it("opens and verifies screen vitals_tracking", () => {
    cy.loginAsRole("rpn");

  cy.visit("/clinical/vitals-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalstracking-screen").should("be.visible");
  cy.getCy("vitalstracking-title").should("be.visible");
  cy.getCy("vitalstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vitals_tracking");

  });
});
