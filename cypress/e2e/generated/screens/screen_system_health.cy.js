// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_health", () => {
  it("opens and verifies screen system_health", () => {
    cy.loginAsRole("cto");

  cy.visit("/executive/system-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemhealth-screen").should("be.visible");
  cy.getCy("systemhealth-title").should("be.visible");
  cy.getCy("systemhealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_health");

  });
});
