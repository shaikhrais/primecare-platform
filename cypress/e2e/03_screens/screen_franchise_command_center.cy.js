// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_command_center", () => {
  it("opens and verifies screen franchise_command_center", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/franchise-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_command_center");

  });
});
