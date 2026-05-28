// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_scheduling_health", () => {
  it("opens and verifies screen coo_scheduling_health", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/coo-scheduling-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooschedulinghealth-screen").should("be.visible");
  cy.getCy("cooschedulinghealth-title").should("be.visible");
  cy.getCy("cooschedulinghealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_scheduling_health");

  });
});
