// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_analytics", () => {
  it("opens and verifies screen hr_director_analytics", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");

  });
});
