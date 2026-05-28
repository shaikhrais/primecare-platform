// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_compliance", () => {
  it("opens and verifies screen hr_director_compliance", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcompliance-screen").should("be.visible");
  cy.getCy("hrdirectorcompliance-title").should("be.visible");
  cy.getCy("hrdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_compliance");

  });
});
