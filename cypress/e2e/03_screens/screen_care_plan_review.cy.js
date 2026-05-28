// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - care_plan_review", () => {
  it("opens and verifies screen care_plan_review", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplanreview-screen").should("be.visible");
  cy.getCy("careplanreview-title").should("be.visible");
  cy.getCy("careplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_plan_review");

  });
});
