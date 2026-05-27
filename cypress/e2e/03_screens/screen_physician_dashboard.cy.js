// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physician_dashboard", () => {
  it("opens and verifies screen physician_dashboard", () => {
    cy.loginAsRole("physician");

  cy.visit("/clinical/physician-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  cy.getCy("physiciandashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_dashboard");

  });
});
