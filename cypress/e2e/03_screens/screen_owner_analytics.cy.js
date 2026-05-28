// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_analytics", () => {
  it("opens and verifies screen owner_analytics", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_analytics");

  });
});
