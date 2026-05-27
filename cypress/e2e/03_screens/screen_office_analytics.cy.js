// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_analytics", () => {
  it("opens and verifies screen office_analytics", () => {
    cy.loginAsRole("admin");

  cy.visit("/common/office-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeanalytics-screen").should("be.visible");
  cy.getCy("officeanalytics-title").should("be.visible");
  cy.getCy("officeanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_analytics");

  });
});
