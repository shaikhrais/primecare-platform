// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - care_plan", () => {
  it("opens and verifies screen care_plan", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplan-screen").should("be.visible");
  cy.getCy("careplan-title").should("be.visible");
  cy.getCy("careplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_plan");

  });
});
