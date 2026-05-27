// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_compliance", () => {
  it("opens and verifies screen general_manager_compliance", () => {
    cy.loginAsRole("gm");

  cy.visit("/management/general-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagercompliance-screen").should("be.visible");
  cy.getCy("generalmanagercompliance-title").should("be.visible");
  cy.getCy("generalmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_compliance");

  });
});
