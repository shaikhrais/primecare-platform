// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_command_center", () => {
  it("opens and verifies screen franchise_owner_command_center", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");

  });
});
