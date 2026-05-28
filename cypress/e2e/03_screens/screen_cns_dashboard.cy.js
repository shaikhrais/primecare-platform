// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cns_dashboard", () => {
  it("opens and verifies screen cns_dashboard", () => {
    cy.loginAsRole("cns");

  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_dashboard");

  });
});
