// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_command_center4_k", () => {
  it("opens and verifies screen franchise_command_center4_k", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");

  });
});
