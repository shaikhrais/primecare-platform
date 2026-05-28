// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_compliance", () => {
  it("opens and verifies screen scrum_master_compliance", () => {
    cy.loginAsRole("scrum_master");

  cy.visitWithSemantics("/management/scrum-master-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummastercompliance-screen").should("be.visible");
  cy.getCy("scrummastercompliance-title").should("be.visible");
  cy.getCy("scrummastercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_compliance");

  });
});
