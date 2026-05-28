// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_screen_dashboard", () => {
  it("opens and verifies screen dynamic_screen_dashboard", () => {
    cy.loginAsRole("guest");

  cy.visitWithSemantics("/common/dynamic-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicdashboard-screen").should("be.visible");
  cy.getCy("dynamicdashboard-title").should("be.visible");
  cy.getCy("dynamicdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_screen_dashboard");

  });
});
