// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_care_plans", () => {
  it("opens and verifies screen rn_care_plans", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-care-plans");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplans-screen").should("be.visible");
  cy.getCy("rncareplans-title").should("be.visible");
  cy.getCy("rncareplans-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_care_plans");

  });
});
