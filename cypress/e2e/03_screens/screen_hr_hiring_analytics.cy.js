// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_analytics", () => {
  it("opens and verifies screen hr_hiring_analytics", () => {
    cy.loginAsRole("hr_hiring");

  cy.visitWithSemantics("/staff/hr-hiring-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringanalytics-screen").should("be.visible");
  cy.getCy("hrhiringanalytics-title").should("be.visible");
  cy.getCy("hrhiringanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_analytics");

  });
});
