// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_hub_dashboard", () => {
  it("opens and verifies screen training_hub_dashboard", () => {
    cy.loginAsRole("training");

  cy.visit("/common/training-hub-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubdashboard-screen").should("be.visible");
  cy.getCy("traininghubdashboard-title").should("be.visible");
  cy.getCy("traininghubdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_hub_dashboard");

  });
});
