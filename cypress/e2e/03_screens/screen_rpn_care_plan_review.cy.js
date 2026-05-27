// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_care_plan_review", () => {
  it("opens and verifies screen rpn_care_plan_review", () => {
    cy.loginAsRole("rpn");

  cy.visit("/rpn/rpn-care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncareplanreview-screen").should("be.visible");
  cy.getCy("rpncareplanreview-title").should("be.visible");
  cy.getCy("rpncareplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_care_plan_review");

  });
});
