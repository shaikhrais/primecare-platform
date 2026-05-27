// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_compliance", () => {
  it("opens and verifies screen regional_bdm_compliance", () => {
    cy.loginAsRole("regional_bdm");

  cy.visit("/management/regional-bdm-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmcompliance-screen").should("be.visible");
  cy.getCy("regionalbdmcompliance-title").should("be.visible");
  cy.getCy("regionalbdmcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_compliance");

  });
});
