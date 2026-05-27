// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_care_plans", () => {
  it("opens and verifies screen hsw_care_plans", () => {
    cy.loginAsRole("hsw");

  cy.visit("/clinical/hsw-care-plans");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswcareplans-screen").should("be.visible");
  cy.getCy("hswcareplans-title").should("be.visible");
  cy.getCy("hswcareplans-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_care_plans");

  });
});
