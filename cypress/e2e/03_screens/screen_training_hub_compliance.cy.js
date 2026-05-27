// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_hub_compliance", () => {
  it("opens and verifies screen training_hub_compliance", () => {
    cy.loginAsRole("training");

  cy.visit("/common/training-hub-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubcompliance-screen").should("be.visible");
  cy.getCy("traininghubcompliance-title").should("be.visible");
  cy.getCy("traininghubcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_compliance");

  });
});
