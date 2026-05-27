// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_compliance", () => {
  it("opens and verifies screen cx_director_compliance", () => {
    cy.loginAsRole("cx_director");

  cy.visit("/executive/cx-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");

  });
});
