// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - enterprise_command_center4_k", () => {
  it("opens and verifies screen enterprise_command_center4_k", () => {
    cy.loginAsRole("ceo");

  cy.visitWithSemantics("/executive/enterprise-command-center4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisecommandcenter4k-screen").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-title").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("enterprise_command_center4_k");

  });
});
