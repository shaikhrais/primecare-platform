// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduling_health", () => {
  it("opens and verifies screen scheduling_health", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulinghealth-screen").should("be.visible");
  cy.getCy("schedulinghealth-title").should("be.visible");
  cy.getCy("schedulinghealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_health");

  });
});
