// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_dashboard", () => {
  it("opens and verifies screen franchise_dashboard", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");

  });
});
