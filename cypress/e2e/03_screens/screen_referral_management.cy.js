// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - referral_management", () => {
  it("opens and verifies screen referral_management", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/executive/referral-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("referralmanagement-screen").should("be.visible");
  cy.getCy("referralmanagement-title").should("be.visible");
  cy.getCy("referralmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("referral_management");

  });
});
