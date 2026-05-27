// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staffing_overview", () => {
  it("opens and verifies screen staffing_overview", () => {
    cy.loginAsRole("coo");

  cy.visit("/executive/staffing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffingoverview-screen").should("be.visible");
  cy.getCy("staffingoverview-title").should("be.visible");
  cy.getCy("staffingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staffing_overview");

  });
});
