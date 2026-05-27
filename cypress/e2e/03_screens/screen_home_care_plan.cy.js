// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - home_care_plan", () => {
  it("opens and verifies screen home_care_plan", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/home-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("homecareplan-screen").should("be.visible");
  cy.getCy("homecareplan-title").should("be.visible");
  cy.getCy("homecareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("home_care_plan");

  });
});
