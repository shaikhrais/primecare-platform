// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_overview", () => {
  it("opens and verifies screen family_overview", () => {
    cy.loginAsRole("family");

  cy.visit("/common/family-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_overview");

  });
});
