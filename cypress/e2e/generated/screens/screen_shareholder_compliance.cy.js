// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shareholder_compliance", () => {
  it("opens and verifies screen shareholder_compliance", () => {
    cy.loginAsRole("shareholder");

  cy.visit("/executive/shareholder-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholdercompliance-screen").should("be.visible");
  cy.getCy("shareholdercompliance-title").should("be.visible");
  cy.getCy("shareholdercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_compliance");

  });
});
