// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_analytics", () => {
  it("opens and verifies screen regional_bdm_analytics", () => {
    cy.loginAsRole("regional_bdm");

  cy.visitWithSemantics("/management/regional-bdm-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmanalytics-screen").should("be.visible");
  cy.getCy("regionalbdmanalytics-title").should("be.visible");
  cy.getCy("regionalbdmanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_analytics");

  });
});
