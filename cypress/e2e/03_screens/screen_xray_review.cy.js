// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - xray_review", () => {
  it("opens and verifies screen xray_review", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/xray-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("xray_review");

  });
});
