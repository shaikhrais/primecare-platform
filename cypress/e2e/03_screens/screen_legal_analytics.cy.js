// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - legal_analytics", () => {
  it("opens and verifies screen legal_analytics", () => {
    cy.loginAsRole("legal");

  cy.visit("/executive/legal-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalanalytics-screen").should("be.visible");
  cy.getCy("legalanalytics-title").should("be.visible");
  cy.getCy("legalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_analytics");

  });
});
