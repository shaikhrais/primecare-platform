// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_hub_analytics", () => {
  it("opens and verifies screen training_hub_analytics", () => {
    cy.loginAsRole("training");

  cy.visit("/common/training-hub-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubanalytics-screen").should("be.visible");
  cy.getCy("traininghubanalytics-title").should("be.visible");
  cy.getCy("traininghubanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_analytics");

  });
});
