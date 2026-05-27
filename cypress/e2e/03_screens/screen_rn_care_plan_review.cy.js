// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_care_plan_review", () => {
  it("opens and verifies screen rn_care_plan_review", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplanreview-screen").should("be.visible");
  cy.getCy("rncareplanreview-title").should("be.visible");
  cy.getCy("rncareplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_care_plan_review");

  });
});
