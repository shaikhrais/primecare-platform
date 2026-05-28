// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_care_plan", () => {
  it("opens and verifies screen psw_care_plan", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/psw-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcareplan-screen").should("be.visible");
  cy.getCy("pswcareplan-title").should("be.visible");
  cy.getCy("pswcareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_care_plan");

  });
});
